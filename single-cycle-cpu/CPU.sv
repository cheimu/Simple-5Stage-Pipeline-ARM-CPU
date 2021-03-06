module CPU (clk, reset);

	input logic clk, reset;
	logic negative, zero, overflow;
	logic [5:0] shamt; 
	logic [15:0] DAddr16;
	logic [8:0] DAddr9;
	logic [11:0] DAddr12;
	logic [4:0] Rd, Rm, Rn;
	logic MemWrite, MemRead, MemToReg, ALUSrc, RegWrite, Move, ZorK, Bor8, Reg2Loc, IorR;
	logic [18:0] CondAddr19;
	logic [2:0] ALUOp;
    logic [25:0] BrAddr26;
	logic [31:0] instruction;
	logic BrTaken, UncondBr;
	logic [3:0] xfer;
	 
	instr_fetch fetch_instruction (instruction, BrTaken, UncondBr, CondAddr19, BrAddr26, clk, reset);
	
	controls control_unit (instruction, overflow, negative, zero, Rd, Rm, Rn, Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite, Move, ZorK, IorR, Bor8, DAddr16, DAddr9, DAddr12, shamt, 
								 CondAddr19, BrAddr26,BrTaken, UncondBr, xfer, 
								 clk);
	
	computation computation_unit (overflow, negative, zero, Rd, Rm, Rn, Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite, Move, 
							ZorK, IorR, Bor8, DAddr16, DAddr9, DAddr12, shamt, xfer ,clk);
endmodule 


`timescale 1ns/10ps

module CPU_testbench();
 logic reset, CLOCK_50;


 CPU dut (CLOCK_50, reset);
 
 parameter CLOCK_50_PERIOD=400000;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_50_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin 
	reset <=1;	@(posedge CLOCK_50);
	reset <=0; @(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	repeat(2000) begin
		
		@(posedge CLOCK_50);
	end
	$stop;
	end
endmodule

