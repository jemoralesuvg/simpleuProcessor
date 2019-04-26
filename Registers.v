module Registers (
    input nclk, enable,
	input [3:0] address_A, address_B, address_D,
	input [7:0] data_in,
	output [7:0] out_A, out_B
);

  	reg [7:0] memory [0:16];
  
  	assign out_A = memory[address_A];
  	assign out_B = memory[address_B];
  
  	always @ (negedge nclk) begin
		if(enable == 1) begin
			memory[address_D] <= data_in;
			//$display("R%d = %d",address_D, data_in);
      	end
  	end
  
  // reset memory
  	integer i;
  	initial begin
      for (i = 0; i < 128; i= i + 1) 
        memory[i] = i;
    end
	
endmodule