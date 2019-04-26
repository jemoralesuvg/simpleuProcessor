module Inst_Memory(
  input[7:0]address,
  output[15:0] data_out
);
  wire [15:0] data_out;
  reg [15:0] memory [0:256];
  
  assign data_out = memory[address];
  
initial begin
 $readmemh("instructions.list", memory);
end
endmodule