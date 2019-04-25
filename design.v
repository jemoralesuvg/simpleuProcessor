// Code your design here
module Moore_1101 (
  input clk,
  input A,
  input reset,
  output Out,
  output [2:0] S
);

  reg Out = 0;
  reg [2:0] S = 0;  
  wire [2:0] S_fut=0 ;
  
  wire s01;
  assign s01 = (~S[2]&~S[1]&~S[0]&A);
  
  wire s02=(S[1]&~S[0]&~A);
  wire s03= s01|s02;

  assign S_fut[0] = (~S[2]&~S[1]&~S[0]&A) | (S[1]&~S[0]&~A); //
  assign S_fut[1] = (~S[1]&S[0]&A) | (S[2]&A) | ( S[1] & ~S[0] ); //
  assign S_fut[2] = ( S[1] & S[0] & A);
  
  initial
    begin
      S = 3'b0;
    end
  // en cada flanco a positivo se guarda en los flip flops S[2:0]
  always @ (posedge clk)
    begin
      if (reset)
        begin
          S <= 0;
          $display("reset S=%b \tS fut=%b \tA=%b \tS01=%b \tS02=%b \tS03=%b", S, S_fut, A, s01, s02, s03);
        end
      else
        begin
          S[0] <= S_fut[0]; // (~S[2]&~S[1]&~S[0]&A) | (S[1]&~S[0]&~A);//
          S[1] <= S_fut[1]; //(~S[1]&S[0]&A) | (S[1]&~S[0]) | (S[2]&A); //;
          S[2] <= ( S[1] & S[0] & A);
          // lógica combinacional de la salida
          Out <= S[2];
          $display("S=%b \tS fut=%b \tA=%b", S, S_fut, A);

        end;
    end
  
 //
  
endmodule