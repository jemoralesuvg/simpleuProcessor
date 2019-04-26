module Counter(
  input clk, reset, 
  output [10:0] out
);
  reg [10:0]out;
  
  	always @ (posedge clk)
      if(reset) begin
      	out <= 0;
      end else begin
          out <= out + 1;
      end
  
initial begin
    out <= 1'b0;
end
endmodule