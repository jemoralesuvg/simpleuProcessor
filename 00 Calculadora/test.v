`include "Inst_Memory.v"
`include "Program_Counter.v" 
`include "Registers.v"
`include "ALU.v"

module test;
	// wires y regs
	reg clk, reset;
	wire [10:0] pc_count;
	wire [13:0] instruction;
	wire [7:0]	a, b, data;
	wire [3:0]	addres_A, addres_B, addres_D;
	wire [1:0]	control;
	
	// bit swizzling
	assign addres_A = instruction[11:8];
	assign addres_B = instruction[7:4];
	assign addres_D = instruction[3:0];
	assign control = instruction[13:12];
	
	// calculator
	Counter 	PC1 	(clk, reset, pc_count);
	Inst_Memory	Inst1 	(pc_count, instruction);
	Registers	Reg1	(clk, addres_A, addres_B, addres_D, data, a, b);
	ALU			ALU1	(control, a, b, data);
	
	
	initial begin
		$display("PC \tInst \tD \tA \tB");
		$monitor("%d \t%h \t%d \t%d \t%d", pc_count, instruction, data, a, b);
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
