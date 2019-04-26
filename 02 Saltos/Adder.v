module Adder(
  input [7:0] a,b,
  output [7:0] out
);
  reg [7:0] out;
  
  always @ *
	out = a + b;
    
	
endmodule