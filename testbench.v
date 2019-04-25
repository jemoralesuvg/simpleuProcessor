//-----------------------------------------------------
// José Eduardo Morales
// Maquina de estados Finitos - Moore
// Cuando lee una cadena 1101 y despliega 1
//-----------------------------------------------------

`include "design.v"

module testbench();
  // entradas y salidas
  reg entrada;
  reg clk, reset;
  wire salida;
  wire [2:0] estado;
  
  // conectamos la maquina de estados
  Moore_1101 FSM (clk, entrada, reset, salida, estado);
  
  // simulación
  initial
    begin
      // calores iniciales
      entrada = 0;
      reset = 1;
      clk = 1;
      // preparar la consola
      $display("\t\t Time \tIn \tOut, \tState");
      $monitor("%d \t%d \t%d \t%b", $time, entrada, salida, estado); 
      // variación de las entradas
      #10 reset = 0;
      #20 entrada = 1;
      #10 entrada = 1;
      #10 entrada = 0;
      #10 entrada = 1;
      #10 entrada = 1;
      #10 entrada = 1;
      reset = 1;
      #10 entrada = 1;
      reset=0;
      #10 entrada = 0;
      #10 entrada = 0;
      #10 entrada = 1;
      #10 entrada = 1;
      #10 entrada = 0;
      #10 entrada = 1;
      #10 entrada = 1;
    end
  
  // tiempo final
  initial 
    #200 $finish;
  // señal de reloj
  always
    #5 clk = ~clk;
  
  // señales
  initial 
    begin
  	  $dumpfile("dump.vcd");
  	  $dumpvars(1);
    end
endmodule