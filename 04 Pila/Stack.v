module Stack(
	input nclk, count_up, count_down,
	input [7:0] data_in,
	output [7:0] data_out
);

  wire [7:0] data_out;
  reg [7:0] memory [0:16];
  reg [3:0] pointer;
  
  // asynchronous output
  assign data_out = memory[pointer];
  
  always @ (negedge nclk)begin
	if (count_up) begin //CALL
		memory[pointer] = data_in;
		//$display("Stack[%d] = %d", pointer, data_in);
		pointer = pointer + 1;
	end
	else if (count_down) begin	//RETURN
		pointer = pointer - 1;
	end
  end
	// valores iniciales al Stack
	integer i;
initial begin
	pointer = 4'b0;
	for (i = 0; i < 16; i= i + 1) 
        memory[i] = i;
end
endmodule