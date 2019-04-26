module Data_Memory(
	input nclk, enable,
	input[7:0] address, data_in,
	output[7:0] data_out
);
  wire [7:0] data_out;
  reg [7:0] memory [0:256];
  
  assign data_out = memory[address];
  
  always @ (negedge nclk)begin
	if (enable)
		memory[address] <= data_in;
  end
  
	integer i;
initial begin
	for (i = 0; i < 256; i= i + 1) 
        memory[i] = i;
end
endmodule