module controls (instruction, overflow, negative, zero, Rd, Rm, Rn, Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite, Move, ZorK, IorR, Bor8, DAddr16, DAddr9, DAddr12, shamt, 
					CondAddr19, BrAddr26, BrTaken, UncondBr, xfer,
					clk);
	input logic [31:0] instruction;
	input logic negative, zero, clk, overflow;
	output logic [4:0] Rd, Rn, Rm;
	output logic Reg2Loc, MemWrite, MemRead, MemToReg, ALUSrc, RegWrite, Move, ZorK, IorR, Bor8, BrTaken, UncondBr;
	output logic [15:0] DAddr16;
	output logic [8:0] DAddr9;
	output logic [11:0] DAddr12;
	output logic [5:0] shamt;
	output logic [18:0] CondAddr19;
	output logic [25:0] BrAddr26;
	output logic [3:0] xfer;
	logic [12:0] control;
	logic negative_saved, overflow_saved;
	logic flagControl;
	output logic [2:0] ALUOp;
	 
	D_FF  savedNeg(negative_saved, (flagControl & negative) | (~flagControl & negative_saved), 1'b0, clk);
	D_FF  savedOver(overflow_saved, (flagControl & overflow) | (~flagControl & overflow_saved), 1'b0, clk);
	assign {Reg2Loc, MemWrite, MemRead, MemToReg, ALUOp, ALUSrc, RegWrite, Move, ZorK, IorR, Bor8} = control;
	 
	always_comb begin
		// addi
		if (instruction[31:26] == 6'b100100) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 5'b11111;
			DAddr12 = instruction[21:10];
			control = 13'b0000010110000;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// adds
		else if (instruction[31:26] == 6'b101010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = instruction[20:16];
			DAddr12 = 12'b0;
			control = 13'b1000010010000;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b1;
		end
		// subs
		else if (instruction[31:26] == 6'b111010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = instruction[20:16];
			DAddr12 = 12'b0;
			control = 13'b1000011010000;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b1;
		end
		// b unconditional branch
		else if (instruction[31:26] == 6'b000101) begin
			Rd = 0;
			Rn = 0;
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0;
			BrTaken = 1;
			UncondBr = 1'b1;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = instruction [25:0];
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// cbz
		else if (instruction[31:26] == 6'b101101) begin
			Rd = instruction[4:0];
			Rn = 5'b11111;
			Rm = 5'b11111;
			DAddr12 = 12'b0;
			control = 13'b0000010000000;
			BrTaken = zero;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = instruction[23:5];
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// stur
		else if (instruction[31:21] == 11'b11111000000) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0101010100010;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// ldur
		else if (instruction[31:21] == 11'b11111000010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0011010110010;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// b.lt
		else if (instruction[31:26] == 6'b010101) begin
			Rd = 0;
			Rn = 0;
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0000010000000;
			BrTaken = (negative_saved != overflow_saved);
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = instruction[23:5];
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// movz
		else if (instruction[31:26] == 6'b110100) begin
			Rd = instruction[4:0];
			Rn = 0;
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0000010111000;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = instruction[20:5];
			DAddr9 = 9'b0;
			shamt = {4'b0000, instruction[22:21]};
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// movk
		else if (instruction[31:26] == 6'b111100) begin
			Rd = instruction[4:0];
			Rn = 5'b11111;
			Rm = 5'b11111;
			DAddr12 = 12'b0;
			control = 13'b0000010011100;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = instruction[20:5];
			DAddr9 = 9'b0;
			shamt = {4'b0000, instruction[22:21]};
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
		// sturb
		else if (instruction[31:21] == 11'b00111000000) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0101010100011;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b0001;
			flagControl = 1'b0;
		end
		// ldurb
		else if (instruction[31:21] == 11'b00111000010) begin
			Rd = instruction[4:0];
			Rn = instruction[9:5];
			Rm = 0;
			DAddr12 = 12'b0;
			control = 13'b0011010110011;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = instruction[20:12];
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b0001;
			flagControl = 1'b0;
		end
		// default
		else begin
			Rd = 5'b11111;
			Rn = 5'b11111;
			Rm = 5'b11111;
			DAddr12 = 12'b0;
			control = 13'b0000010000000;
			BrTaken = 0;
			UncondBr = 0;
			DAddr16 = 16'b0;
			DAddr9 = 9'b0;
			shamt = 6'b0;
			CondAddr19 = 19'b0;
			BrAddr26 = 26'b0;
			xfer = 4'b1000;
			flagControl = 1'b0;
		end
	end
endmodule 