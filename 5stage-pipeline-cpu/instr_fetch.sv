module instr_fetch (instruction, BrTaken, UncondBr, CondAddr19, BrAddr26, clk, rst);
	output logic [31:0] instruction;
	input logic BrTaken, UncondBr, clk, rst;
	input logic [18:0] CondAddr19;
	input logic [25:0] BrAddr26;
	logic [63:0] instru_addr;
	logic [63:0] instru_addr_in;
	
	
	logic [63:0] normalAddr;
	adder_64 compute_normal (normalAddr, instru_addr, 64'b100);
	
	logic [63:0] condaddr;
	se19_64 name0 (condaddr, CondAddr19);
	
	logic [63:0] condaddr_1;
	minusOne mo(condaddr_1, condaddr);
	
	logic [63:0] braddr;
	se26_64 name1 (braddr, BrAddr26);
	
	logic [63:0] braddr_1;
	minusOne mo1(braddr_1, braddr);
	
	logic [63:0] gotoaddr;
	mux2_1 br_or_cond (gotoaddr, condaddr_1, braddr_1, UncondBr);
	
	logic [63:0] computed_gotoaddr;
	shifter shift_2(gotoaddr, 1'b0, 6'b10, computed_gotoaddr);
	
	logic [63:0] branchAddr;
	adder_64 compute_branch (branchAddr, instru_addr, computed_gotoaddr);
	
	mux2_1 brTak (instru_addr_in, normalAddr, branchAddr, BrTaken);
	
	pc program_counter (instru_addr, instru_addr_in, clk, rst);
	
	instructmem instr_mem (instru_addr, instruction, clk);

endmodule 


`timescale 1ns/10ps

module instr_fetch_testbench();
    logic [31:0] instruction;
	logic BrTaken, UncondBr, CLOCK_50, reset;
	logic [18:0] CondAddr19;
	logic [25:0] BrAddr26;

 instr_fetch dut (instruction, BrTaken, UncondBr, CondAddr19, BrAddr26, CLOCK_50, reset);
 
 parameter CLOCK_50_PERIOD=5000;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_50_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin 
	reset <=1;BrTaken <= 0; UncondBr <= 0;	@(posedge CLOCK_50);
	reset <=0; @(posedge CLOCK_50);
	BrTaken <= 1; UncondBr <= 0; BrAddr26 <= 26'b11111; CondAddr19 <=19'b101010; @(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
   $stop;
	end
endmodule
