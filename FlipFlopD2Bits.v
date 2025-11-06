module FlipFlopD2Bits (
  input clock, reset,
  input [1:0] data,
  output [1:0] saida,
  output [1:0] saida_negada
);
  
  FlipFlopD d_flipflop0 (
    .clock(clock),
    .reset(reset),
    .data(data[0]),
    .saida(saida[0]),
    .saida_negada(saida_negada[0])
  );

  FlipFlopD d_flipflop1 (
    .clock(clock),
    .reset(reset),
    .data(data[1]),
    .saida(saida[1]),
    .saida_negada(saida_negada[1])
  );

endmodule

