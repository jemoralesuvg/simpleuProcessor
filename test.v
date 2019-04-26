`include "Inst_Memory.v"
`include "Program_Counter.v" 
`include "Registers.v"
`include "ALU.v"
`include "MUX.v"
`include "Decode.v"
`include "Adder.v"
`include "Data_Memory.v"
`include "Stack.v"

module test;
	// wires y regs
	reg clk, reset;
	wire [7:0] pc_count;
	wire [15:0] instruction;
	wire [7:0]	a, b, data, inm, bi, bf, j_offset, pc_load;
	wire [7:0] d_alu, d_mem, pc_jump, pc_stack;
	wire [3:0]	address_A, address_B, address_D;
	wire vdd, c_Inm, c_extend, c_cond, zero, c_data, reg_write, mem_write;
	wire s_down, s_up, c_stack;
	wire [1:0]	c_ALU;

	// bit swizzling
	assign address_A = instruction[11:8];
	assign address_B = instruction[7:4];
	assign address_D = instruction[3:0];
	assign inm[3:0] = address_B;
	assign j_offset = instruction[7:0];
	
	
	// procesor
	Counter 	PC	 		(clk, reset, c_cond & zero +  c_stack, pc_load, pc_count);
	Inst_Memory	mem_inst	(pc_count, instruction);
	Decoder		Decode		(instruction[15:12], c_ALU, c_Inm, c_extend, c_cond, 
							reg_write, mem_write, c_data, s_up, s_down, c_stack);
	Registers	Reg1		(clk, reg_write, address_A, address_B, address_D, data, a, b);
	ALU			ALU1		(c_ALU, a, bf, d_alu, zero);
	MUX8_2x1	Inm_B		(c_Inm, b, inm, bi);
	MUX4_2x1	extent		(c_extend, {4{bi[3]}}, address_A , inm[7:4]);
	MUX8_2x1	cond		(c_cond, bi, {8'b0}, bf);
	Adder		PC_Add		(pc_count, j_offset, pc_jump);
	MUX8_2x1	mux_data	(c_data, d_alu, d_mem, data);
	Data_Memory	mem_data	(clk, mem_write, a, b, d_mem);
	MUX8_2x1	mux_stack	(c_stack, pc_jump, pc_stack, pc_load);
	Stack		stack		(clk, s_up, s_down, pc_count,pc_stack);
	
	// monitor
	initial begin
		$display("PC \tInst \tA \tB \tBf \tjump \tload \tstack");
		$monitor("%d \t%h \t%d \t%d \t%d \t%d \t%d \t%d", 
			pc_count, instruction, a, b, j_offset, pc_jump, pc_load, pc_stack);
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
		#400 $finish;
	
	always 
		#5 clk = !clk;
		
endmodule
