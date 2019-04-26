module Registers (
    input nclk, enable,
	input [3:0] address_A, address_B, address_D,
	input [7:0] data_in,
	output [7:0] out_A, out_B
);
    wire [7:0] A, B;
  	reg [7:0] memory [0:16];
	wire [7:0] D;
  
  	assign out_A = memory[address_A];
  	assign out_B = memory[address_B];
  
  	always @ (negedge nclk) begin
		if(enable == 1) begin
			memory[address_D] <= data_in;
      	end
  	end
  
  // reset memory
  	integer i;
  	initial begin
      for (i = 0; i < 128; i= i + 1) 
        memory[i] = 2*i;
    end
	
endmodule