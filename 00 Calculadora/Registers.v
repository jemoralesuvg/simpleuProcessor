module Registers (
    input nclk,
	input [3:0] address_A, address_B, address_D,
	input [7:0] data_in,
	output [7:0] out_A, out_B
);

  	reg [7:0] memory [0:15];
  
  	assign out_A = memory[address_A];
  	assign out_B = memory[address_B];
  
  	always @ (negedge nclk) 
		memory[address_D] <= data_in;
      	
  
  // reset memory
  	integer i;
  	initial begin
      for (i = 0; i < 16; i= i + 1) 
        memory[i] = i;
    end
	
endmodule