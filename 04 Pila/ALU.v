module ALU(
  input [1:0] control,
  input [7:0] a,b,
  output [7:0] out,
  output zero
);
  reg [7:0] out;
  wire zero;
  
  assign zero = !(out[7]|out[6]|out[5]|out[4]|out[3]|out[2]|out[1]|out[0]);
  
  always @ *
    case (control)
      0: out = a + b;
      1: out = a - b;
      2: out = a & b;
      3: out = b;
    endcase
	
endmodule

module Adder(
  input [7:0] a,b,
  output [7:0] out
);
  reg [7:0] out;
  
  always @ *
	out = a + b;
    
	
endmodule