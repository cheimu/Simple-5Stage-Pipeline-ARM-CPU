module computation (overflow, negative, zero, Rd, Rm, Rn, Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite, Move, 
							ZorK, IorR, Bor8, DAddr16, DAddr9, DAddr12, shamt, xfer, clk);
	output logic overflow, negative, zero;
	input logic clk;
	input logic [5:0] shamt; 
	input logic [15:0] DAddr16;
	input logic [8:0] DAddr9;
	input logic [11:0] DAddr12;
	input logic [4:0] Rd, Rm, Rn;
	input logic MemWrite, MemRead, MemToReg, ALUSrc, RegWrite, Move, ZorK, Bor8, Reg2Loc, IorR;
	input [2:0] ALUOp;
	logic carry_out;
	
	logic [4:0] Ab;
	op_mux2_1 r2l (Ab, Rd, Rm, Reg2Loc);
	
	logic [63:0] Da, Db;
	
	logic [63:0] Dw;
	logic [4:0] Aw;
	assign Aw = Rd;
	logic [63:0] DataWriteReg;
	regfile register_file(Da, Db, DataWriteReg, Rn, Ab, Aw, RegWrite, clk);
	
	logic [63:0] computed_iop;
	zero12_64 name0 (computed_iop, DAddr12);
	logic [63:0] extended_addr;
	se9_64 name1 (extended_addr, DAddr9);
	logic [63:0] computed_i;
	mux2_1 name3 (computed_i, computed_iop, extended_addr, IorR);
	
	logic [63:0] computed_Db;
	mux2_1 name7 (computed_Db, Db, computed_i, ALUSrc);
	
	logic [63:0] address;
	alu core (Da, computed_Db, ALUOp, address, negative, zero, overflow, carry_out);

	
	logic [63:0] Dout;
	logic [63:0] Din;
	mux2_1 name4 (Din, Db, {56'b0, Db[7:0]}, Bor8);
	input logic [3:0] xfer;
	datamem disk (address, MemWrite, MemRead, Din, clk, xfer,  Dout);
	
	mux2_1 name5 (Dw, address, Dout, MemToReg);
	
	logic [63:0] loadData; // the thing to be loaded to register
	mux2_1 name6 (loadData, Dw, {56'b0, Dw[7:0]}, Bor8);
	
	logic [63:0] temp0, temp1, shifted_16;
	mult shamt16({58'b0, shamt}, 64'b10000, 1'b1, temp0, temp1);
	
	logic [63:0] movz_result;
	shifter movzd( {48'b0, DAddr16}, 1'b0, temp0[5:0], movz_result);
	
	// masking off middle 16 bits and add the right ones
	logic [63:0] movk_result, index, mask1, mask2;
	assign mask1 = 64'b1111111111111111;
	shifter makemask ( mask1, 1'b0, temp0[5:0], mask2);	// computing mask
	movkMake mk (movk_result, mask2, Dw, movz_result);
	
	// movz or movk
	logic [63:0] mov_result;
	mux2_1 zork (mov_result, movz_result, movk_result, ZorK);
	
	// data from register/memory or movz/movk
	mux2_1 movlock (DataWriteReg, loadData, mov_result, Move);
	
	
	
	
endmodule
	