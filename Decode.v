module Decoder(
  input [3:0] opcode,
  output [1:0] c_ALU,
  output c_Inm, c_extend
);
  wire [1:0] c_ALU;
  wire c_Inm, c_extend;
  
  assign c_ALU = opcode[1:0];
  assign c_Inm = opcode[2];
  assign c_extend = opcode[1] & opcode[1];
  
endmodule