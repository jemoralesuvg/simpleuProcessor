module Inst_Memory(
  input[10:0]address,
  output[13:0] data_out
);
  wire [13:0] data_out;
  reg [13:0] memory [0:1024];
  
  assign data_out = memory[address];
  
initial begin
 $readmemh("instructions.list", memory);
end
endmodule