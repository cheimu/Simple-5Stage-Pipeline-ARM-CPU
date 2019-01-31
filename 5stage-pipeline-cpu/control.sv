module controls (instruction, overflow, negative, zero, Rd, Rm, Rn, Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite_o, Move, ZorK, IorR, Bor8, DAddr16, DAddr9, DAddr12, shamt, 
					CondAddr19Out, BrAddr26Out, BrTaken, UncondBrOut, xfer,
					azf, fa, fb,clk, rst);
	output logic [1:0] fa, fb;				
	input logic [31:0] instruction;
	input logic negative, zero, clk, overflow, rst, azf;
	output logic [4:0] Rd, Rn, Rm;
	output logic Reg2Loc, MemWrite, MemRead, MemToReg, ALUSrc, RegWrite_o, Move, ZorK, IorR, Bor8, BrTaken, UncondBrOut;
	output logic [15:0] DAddr16;
	output logic [8:0] DAddr9;
	output logic [11:0] DAddr12;
	output logic [5:0] shamt;
	output logic [18:0] CondAddr19Out;
	logic [18:0] CondAddr19;
	output logic [25:0] BrAddr26Out;
	output logic [3:0] xfer;
	logic [12:0] control;
	logic negative_saved, overflow_saved;
	logic flagControl;
	logic [4:0] Aa, Ab;
	logic [25:0] BrAddr26;
	logic UncondBr;
	output logic [2:0] ALUOp;
	
	// compute Aa and Ab
	assign Aa = Rn;
	always_comb
		if (Reg2Loc) 
			Ab = Rm;
		else 
			Ab = Rd;
	
	// saved branch addresses
	logic isBranch, savedIsBranch, ifss;
	logic [18:0] savedCondAddr;
	logic [31:0] savedInstruction, savedInstruction1;
	
	D_FF savedUcondBr (UncondBrOut, UncondBr, rst,clk);
	buf26 dv (BrAddr26, BrAddr26Out, clk);
	// saved RegWrite
	logic RegWrite;
	logic [3:0] RegWrite_d;
	assign RegWrite_o = RegWrite_d[3];
	sigeyi s1(RegWrite_d, RegWrite, rst, clk);

	buf32 vv(savedInstruction, instruction, rst, clk);
	buf32 vv1(savedInstruction1, savedInstruction, rst, clk);
	buf19 save_addr (CondAddr19, savedCondAddr, clk);
	doubleWr sf (ifss, flagControl, rst, clk);
	
	// flag storage
	D_FF saveIB (savedIsBranch, isBranch, rst, clk);
	D_FF  savedNeg(negative_saved, (ifss & negative) | (~ifss & negative_saved), rst, clk);
	D_FF  savedOver(overflow_saved, (ifss & overflow) | (~ifss & overflow_saved), rst, clk);
	assign {Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite, Move, ZorK, IorR, Bor8} = control;
	 
	// saved Rd
	logic [4:0] Rd1, Rd2;
	buf5 n(Rd, Rd1, rst, clk);
	buf5 n2(Rd1, Rd2, rst, clk);

	//
	always_comb begin
		// addi
		if (instruction[31:26] == 6'b100100) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 5'b11111;
			DAddr12 = instruction[21:10];
			control = 13'b0000010110000;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 0;
		end
		// adds
		else if (instruction[31:26] == 6'b101010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = instruction[20:16];
			DAddr12 = 12'b0;
			control = 13'b1000010010000;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b1;
			isBranch = 0;
		end
		// subs
		else if (instruction[31:26] == 6'b111010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = instruction[20:16];
			DAddr12 = 12'b0;
			control = 13'b1000011010000;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b1;
			isBranch = 0;
		end
		// b unconditional branch
		else if (instruction[31:26] == 6'b000101) begin
			Rd = 0;
			Rn = 0;
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0;
			UncondBr = 1'b1;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = instruction [25:0];
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 0;
		end
		// cbz
		else if (instruction[31:26] == 6'b101101) begin
			Rd = instruction[4:0];
			Rn = 5'b11111;
			Rm = 5'b11111;
			DAddr12 = 12'b0;
			control = 13'b0000010000000;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = instruction[23:5];
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 1'b1;
		end
		// stur
		else if (instruction[31:21] == 11'b11111000000) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0101010100010;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 1'b0;
		end
		// ldur
		else if (instruction[31:21] == 11'b11111000010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0011010110010;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 1'b0;
		end
		// b.lt
		else if (instruction[31:26] == 6'b010101) begin
			Rd = 0;
			Rn = 0;
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0000010000000;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = instruction[23:5];
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 1'b1;
		end
		// movz
		else if (instruction[31:26] == 6'b110100) begin
			Rd = instruction[4:0];
			Rn = 0;
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0000010111000;
			UncondBr = 0;
			DAddr16 = instruction[20:5];
			DAddr9 = 9'b0;
			shamt = {4'b0000, instruction[22:21]};
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 1'b0;
		end
		// movk
		else if (instruction[31:26] == 6'b111100) begin
			Rd = instruction[4:0];
			Rn = 5'b11111;
			Rm = 5'b11111;
			DAddr12 = 12'b0;
			control = 13'b0000010011100;
			UncondBr = 0;
			DAddr16 = instruction[20:5];
			DAddr9 = 9'b0;
			shamt = {4'b0000, instruction[22:21]};
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 1'b0;
		end
		// sturb
		else if (instruction[31:21] == 11'b00111000000) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0101010100011;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b0001;
			flagControl = 1'b0;
			isBranch = 1'b0;
		end
		// ldurb
		else if (instruction[31:21] == 11'b00111000010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0011010110011;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b0001;
			flagControl = 1'b0;
			isBranch = 1'b0;
		end
		// default
		else begin
			Rd = 5'b11111;
			Rn = 5'b11111;
			Rm = 5'b11111;
			DAddr12 = 12'b0;
			control = 13'b0000010000000;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
			isBranch = 1'b0;
		end
	end
	
	// brach address handled
	always_comb begin 
		if (savedIsBranch) 
			CondAddr19Out = savedCondAddr;
		else
			CondAddr19Out = 19'b0;
		
	end
	
	
	always_comb begin 
		if (savedInstruction[31:26] == 6'b000101)
			BrTaken = 1'b1;
		else if (savedInstruction[31:26] == 6'b101101) 
			BrTaken = azf;
		else if (savedInstruction[31:26] == 6'b010101) 
			if (ifss)
				BrTaken = (overflow != negative);
			else 
				BrTaken = (negative_saved != overflow_saved);
		else 
			BrTaken = 1'b0;
	end
	
	// forwarding  controls
	logic isMov;
	assign isMov = (savedInstruction[31:26] == 6'b110100) | (savedInstruction[31:26] == 6'b111100);
   	
	
	always_comb begin
			if ((Aa == Rd1) & RegWrite_d[0] & isMov & (Rd1 != 5'b11111))
				fa = 2'b11;
			else if ((Aa == Rd1) & RegWrite_d[0] & ~isMov & (Rd1 != 5'b11111))
				fa = 2'b01;
			else if ((Aa == Rd2) & RegWrite_d[1] & (Rd2 != 5'b11111))
				fa = 2'b10;
			else 
				fa = 2'b00;
	end
	
	always_comb begin 
		if ((Ab == Rd1) & RegWrite_d[0] & isMov & (Rd1 != 5'b11111))
			fb = 2'b11;
		else if ((Ab == Rd1) & RegWrite_d[0] & ~isMov & (Rd1 != 5'b11111))
			fb = 2'b01;
		else if ((Ab == Rd2) & RegWrite_d[1] & (Rd2 != 5'b11111))
			fb = 2'b10;
		else 
			fb = 2'b00;
	end
endmodule 