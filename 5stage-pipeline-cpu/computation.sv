module computation (negative, zero, overflow, Rd, Rm, Rn, Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite, Move, 
							ZorK, IorR, Bor8, DAddr16, DAddr9, DAddr12, shamt, xfer, forwardCondA, forwardCondB, azf,clk);
	output logic negative, zero, overflow;
	input logic clk;
	input logic [5:0] shamt; 
	input logic [15:0] DAddr16;
	input logic [8:0] DAddr9;
	input logic [11:0] DAddr12;
	input logic [4:0] Rd, Rm, Rn;
	input logic MemWrite, MemRead, MemToReg, ALUSrc, RegWrite, Move, ZorK, Bor8, Reg2Loc, IorR;
	input logic [2:0] ALUOp; 
	input logic [1:0] forwardCondA, forwardCondB;
	output logic azf;
	logic  carry_out;
	logic [63:0] address;
	logic [2:0] ALUOpi;
	logic [63:0] Dout;
	logic [63:0] mov_result;
	logic zorki;
	logic [63:0] DataWriteReg1;
	logic [63:0] movk_result, index, mask1, mask2;

	
	// buffer between IF&RF
	// Rd
	logic [4:0] Rd1, Rm1, Rn1, Rd4;
	buf5_2 ge (Rd1, Rd4, rst,clk);
	buf5 b_rd (Rd, Rd1, rst,clk);
	// Rm
	buf5 b_rm (Rm, Rm1, rst,clk);
	// Rn
	buf5 b_rn (Rn, Rn1, rst,clk);
	// DAddr12
	logic [11:0] DAddr121;
	buf12 b_daddr12 (DAddr12, DAddr121, clk);
	// DAddr9
	logic [8:0] DAddr91;
	buf9 b_daddr9 (DAddr9, DAddr91, clk);
	// DAddr16
	logic [15:0] DAddr16i;
	buf16 b_daddr16 (DAddr16, DAddr16i, clk);
	
	logic [4:0] Ab;
	logic Reg2Loc_d;
	D_FF regLocDelay (Reg2Loc_d, Reg2Loc, rst, clk);
	op_mux2_1 r2l (Ab, Rd1, Rm1, Reg2Loc_d);
	
	logic [63:0] Da, Db;
	logic [63:0] outa, outb;
	logic [63:0] Dw;
	logic [4:0] Aw;
	logic [63:0] computed_Db;
	assign Aw = Rd4;
	logic [63:0] DataWriteReg;
	regfile register_file(Da, Db, DataWriteReg1, Rn1, Ab, Aw, RegWrite, clk);
	zeroflag zfi (azf, computed_Db);
	
	logic [63:0] computed_iop;
	zero12_64 name0 (computed_iop, DAddr121);
	logic [63:0] extended_addr;
	se9_64 name1 (extended_addr, DAddr91);
	logic [63:0] computed_i;
	logic IorRi;
	D_FF ior (IorRi, IorR, 1'b0, clk);
	mux2_1 name3 (computed_i, computed_iop, extended_addr, IorRi);
	
	logic aluSrci;
	D_FF als (aluSrci, ALUSrc, 1'b0, clk);
	mux2_1 name7 (computed_Db, outb, computed_i, aluSrci);
	
	
	logic [1:0] fa, fb;
	buffer2_2 ss (fa, forwardCondA, reset, clk);
	buffer2_2 dd (fb, forwardCondB, reset, clk);
	
	// forwarding: add 4_1 mux before alu
	// 11:mov_result 10:dataMem 01:alu 00:Regfile
	mux4_1 port_a (outa, {mov_result, DataWriteReg, address, Da}, fa);
	mux4_1 port_b (outb, {mov_result, DataWriteReg, address, Db}, fb);
	
	logic [63:0] Din;
	logic Bor81i;
	D_FF bor (Bor81i, Bor8, 1'b0, clk);
	mux2_1 name4 (Din, outb, {56'b0, outb[7:0]}, Bor81i);
	// buffer between RF&EX
	// Da
	logic [63:0] outa1, outb1;
	buf64 b_aToAlu (outa, outa1, clk);
	// Db
	buf64 b_bToAlu (computed_Db, outb1, clk);
	// Din
	logic [63:0] Dini;
	buf64 b_bor8ToAlu (Din, Dini, clk);
	// MOVZK
	logic [15:0] DAddr161;
	buf16 b_Daddr16_IF_X (DAddr16i, DAddr161, clk);
	

	
	bobo aluo (ALUOpi, ALUOp, clk);
	alu core (outa1, outb1, ALUOpi, address, negative, zero, overflow, carry_out);

	
	
	// buffer between EX&MEM
	// alu result
	logic [63:0] address1;
	buf64 b_afteraddress (address, address1, clk);
	// Din immeidate
	logic [63:0] Din1;
	buf64 b_dataToMem (Dini, Din1, clk);
	// move result
	logic [63:0] mov_result1;
	buf64 b_move (mov_result, mov_result1, clk);
	
	input logic [3:0] xfer;
	datamem disk (address1, MemWrite, MemRead, Din1, clk, xfer,  Dout);
	logic MemToRegi;
	triple mere (MemToRegi, MemToReg, clk);
	mux2_1 name5 (Dw, address1, Dout, MemToRegi);
	
	logic [63:0] loadData; // the thing to be loaded to register
	logic Bor82i;
	triple bo (Bor82i, Bor8, clk);
	mux2_1 name6 (loadData, Dw, {56'b0, Dw[7:0]}, Bor82i);
	
	// delayed shamt
	logic [5:0] shamt_d;
	buf6_2 hhh (shamt, shamt_d, clk);
	
	logic [63:0] temp0, temp1, shifted_16;
	mult shamt16({58'b0, shamt_d}, 64'b10000, 1'b1, temp0, temp1);
	
	logic [63:0] movz_result;
	shifter movzd( {48'b0, DAddr161}, 1'b0, temp0[5:0], movz_result);
	
	// masking off middle 16 bits and add the right ones
	assign mask1 = 64'b1111111111111111;
	shifter makemask ( mask1, 1'b0, temp0[5:0], mask2);	// computing mask
	movkMake mk (movk_result, mask2, outb1, movz_result);
	
	// movz or movk
	
	double zo (zorki, ZorK, clk);
	mux2_1 zork (mov_result, movz_result, movk_result, zorki);
	
	

	// data from register/memory or movz/movk
	logic movei;
	triple mo (movei, Move, clk);
	mux2_1 movlock (DataWriteReg, loadData, mov_result1, movei);
	
	// buffer between MEM&WB
	buf64 b_wbToReg (DataWriteReg, DataWriteReg1, clk);
	
	
	
	
endmodule
	