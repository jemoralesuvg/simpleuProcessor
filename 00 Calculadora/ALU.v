module ALU(
  input [1:0] control,
  input [7:0] a,b,
  output [7:0] out
);
  reg [7:0] out;
  
  always @ *
    case (control)
      0: out = a + b;
      1: out = a - b;
      2: out = a & b;
      3: out = b;
    endcase
	
endmodule