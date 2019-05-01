module Decoder(
  input [3:0] opcode,
  output [1:0] c_ALU, c_B,
  output reg_write, mem_write, c_data, stack_up, stack_down, c_stack
);
  wire [1:0] c_ALU;
  wire c_Inm, c_extend, c_cond, reg_write, mem_write, c_data, stack_up, stack_down, c_stack;
  
  assign c_ALU = opcode[1:0];										//operación de la alu
  assign c_B[0] = opcode[3] | (opcode[2]&opcode[1]&opcode[0]);
  assign c_B[1] = opcode[3] | (opcode[2]&!(opcode[1]&opcode[0]));	// operando B
  assign reg_write = !opcode[3] | (opcode[3]&opcode[2]&opcode[1]&opcode[0]);	
  assign mem_write = opcode[3]&!opcode[2]&opcode[1]&opcode[0];
  assign c_data = (opcode[3]);										// alu o memoria
  assign stack_up = opcode[3]&opcode[2]&opcode[1]&!opcode[0];		// call
  assign stack_down = opcode[3]&opcode[2]&!opcode[1];				// return
  assign c_stack = opcode[3]&opcode[2]&!opcode[1];					// mux de jump o stack
  
endmodule