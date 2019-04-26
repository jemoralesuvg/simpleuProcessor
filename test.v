`include "Inst_Memory.v"
`include "Program_Counter.v" 
`include "Registers.v"
`include "ALU.v"
`include "MUX.v"
`include "Decode.v"

module test;
	// wires y regs
	reg clk, reset;
	wire [10:0] pc_count;
	wire [15:0] instruction;
	wire [7:0]	a, b, data, inm, bi;
	wire [3:0]	address_A, address_B, address_D;
	wire vdd, c_Inm, c_extend;
	wire [1:0]	c_ALU;

	assign vdd = 1;
	// bit swizzling
	assign address_A = instruction[11:8];
	assign address_B = instruction[7:4];
	assign address_D = instruction[3:0];
	assign inm[3:0] = address_B;
	
	// calculator
	Counter 	PC1 	(clk, reset, pc_count);
	Inst_Memory	Inst1 	(pc_count, instruction);
	Decoder		Decode	(instruction[15:12], c_ALU, c_Inm, c_extend);
	Registers	Reg1	(clk, vdd, address_A, address_B, address_D, data, a, b);
	ALU			ALU1	(c_ALU, a, bi, data);
	MUX8_2x1	Inm_B	(c_Inm, b, inm, bi);
	MUX4_2x1	extent	( c_extend, {4{b[3]}}, address_A , inm[7:4]);
	
	initial begin
		$display("PC \tInst \tD \tA \tB");
		$monitor("%d \t%h \t%d \t%d \t%d", pc_count, instruction, data, a, bi);
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
