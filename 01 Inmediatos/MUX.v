module MUX8_2x1(
  input select,
  input [7:0] d0,
  input [7:0] d1,
  output [7:0] out
);
  reg [7:0] out;
  
  always @ *
    case (select)
      0: out = d0;
      1: out = d1;
    endcase
endmodule

module MUX4_2x1(
  input select,
  input [3:0] d0,
  input [3:0] d1,
  output [3:0] out
);
  reg [3:0] out;
  
  always @ *
    case (select)
      0: out = d0;
      1: out = d1;
    endcase
endmodule