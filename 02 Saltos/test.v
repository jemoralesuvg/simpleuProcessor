`include "Inst_Memory.v"
`include "Program_Counter.v" 
`include "Registers.v"
`include "ALU.v"
`include "MUX.v"
`include "Decode.v"
`include "Adder.v"

module test;
	// wires y regs
	reg clk, reset;
	wire [7:0] pc_count;
	wire [15:0] instruction;
	wire [7:0]	a, b, data, inm, bi, bf, j_offset, pc_load;
	wire [3:0]	address_A, address_B, address_D;
	wire vdd, c_Inm, c_extend, c_cond, zero;
	wire [1:0]	c_ALU;

	assign vdd = 1;
	// bit swizzling
	assign address_A = instruction[11:8];
	assign address_B = instruction[7:4];
	assign address_D = instruction[3:0];
	assign inm[3:0] = address_B;
	assign j_offset = instruction[7:0];
	
	
	// calculator
	Counter 	PC1 	(clk, reset, c_cond & zero , pc_load, pc_count);
	Inst_Memory	Inst1 	(pc_count, instruction);
	Decoder		Decode	(instruction[15:12], c_ALU, c_Inm, c_extend, c_cond);
	Registers	Reg1	(clk, vdd, address_A, address_B, address_D, data, a, b);
	ALU			ALU1	(c_ALU, a, bf, data, zero);
	MUX8_2x1	Inm_B	(c_Inm, b, inm, bi);
	MUX4_2x1	extent	(c_extend, {4{b[3]}}, address_A , inm[7:4]);
	MUX8_2x1	cond	(c_cond, bi, {8'b0}, bf);
	Adder		PC_Add	(pc_count, j_offset, pc_load);
	
	initial begin
		$display("PC \tInst \tD \tA \tB \tZero \tPCL");
		$monitor("%d \t%h \t%d \t%d \t%d \t%d \t%d", pc_count, instruction, data, a, bf, zero, pc_load);
	end
	
	initial begin
		clk = 0;
		reset = 1;
		#1 clk = 1;
		#1 clk = 0;
		#1 reset = 0;
	end
	
	initial 
		#200 $finish;
	
	always 
		#5 clk = !clk;
endmodule
