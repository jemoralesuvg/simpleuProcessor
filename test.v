`include "Memory.v"
`include "Program_Counter.v" 
`include "ALU.v"
`include "MUX.v"
`include "Decode.v"
`include "Stack.v"

module test;
	// wires y regs
	reg clk, reset;
	wire [7:0] pc_count;
	wire [15:0] instruction;
	wire [7:0]	a, b, bf, data, inm, inmB, j_offset, pc_load;
	wire [7:0] d_alu, d_mem, pc_jump, pc_stack;
	wire [3:0]	address_A, address_B, address_D, opcode;
	wire vdd, c_Inm, c_extend, c_cond, zero, c_data, reg_write, mem_write;
	wire s_down, s_up, c_stack;
	wire [1:0]	c_ALU, c_B;

	// bit swizzling
	assign opcode = instruction[15:12];
	assign address_A = instruction[11:8];
	assign address_B = instruction[7:4];
	assign address_D = instruction[3:0];
	assign inm[3:0] = address_B;
	assign inm[7:4] = address_A;
	assign inmB[7:4] = {4{address_B[3]}};
	assign inmB[3:0] = address_B;
	assign j_offset = instruction[7:0];
	
	
	// procesor
	Counter 	PC	 		(clk, reset, c_cond & zero |  c_stack, pc_load, pc_count);
	ROM			mem_inst	(pc_count, instruction);
	Decoder		decode		(opcode, c_ALU, c_B, reg_write, mem_write, c_data, s_up, s_down, c_stack);
	Registers	regs		(clk, reg_write, address_A, address_B, address_D, data, a, b);
	ALU			ALU1		(c_ALU, a, bf, d_alu, zero);	
	Adder		pc_add		(pc_count, j_offset, pc_jump);
	MUX8_2x1	mux_data	(c_data, d_alu, d_mem, data);
	RAM			mem_data	(clk, mem_write, a, b, d_mem);
	MUX8_2x1	mux_stack	(c_stack, pc_jump, pc_stack, pc_load);
	Stack		stack		(clk, s_up, s_down, pc_count,pc_stack);
	MUX8_4x1	select_B	(c_B, b, inm, inmB, 8'b0, bf);
	
	// monitor
	initial begin
		$display("PC \tInst \tALU_A \tALU_B \tData \tjump");
		$monitor("%d \t%h \t%d \t%d \t%d \t%d", 
			pc_count, instruction, a, bf, data, pc_jump, );
	end
	
	// reset inicial
	initial begin
		clk = 0;
		reset = 1;
		#1 clk = 1;
		#1 clk = 0;
		#1 reset = 0;
	end
	
	initial 
		#300 $finish;
	
	always 
		#5 clk = !clk;
		
endmodule
