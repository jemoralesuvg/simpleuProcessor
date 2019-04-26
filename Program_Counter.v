module Counter(
  input clk, reset, load, 
  input [7:0] in,
  output [7:0] out
);
  reg [7:0]out;
  
  	always @ (posedge clk)
      if(reset)
		out <= 0;
      else if (load)
		out <= in;
		else
          out <= out + 1;
  
initial begin
    out <= 1'b0;
end
endmodule