module FlipFlopD8Bits (
  input clock, reset,
  input [7:0] data,
  output [7:0] saida,
  output [7:0] saida_negada
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

  FlipFlopD d_flipflop2 (
    .clock(clock),
    .reset(reset),
    .data(data[2]),
    .saida(saida[2]),
    .saida_negada(saida_negada[2])
  );

  FlipFlopD d_flipflop3 (
    .clock(clock),
    .reset(reset),
    .data(data[3]),
    .saida(saida[3]),
    .saida_negada(saida_negada[3])
  );

  FlipFlopD d_flipflop4 (
    .clock(clock),
    .reset(reset),
    .data(data[4]),
    .saida(saida[4]),
    .saida_negada(saida_negada[4])
  );

  FlipFlopD d_flipflop5 (
    .clock(clock),
    .reset(reset),
    .data(data[5]),
    .saida(saida[5]),
    .saida_negada(saida_negada[5])
  );

  FlipFlopD d_flipflop6 (
    .clock(clock),
    .reset(reset),
    .data(data[6]),
    .saida(saida[6]),
    .saida_negada(saida_negada[6])
  );

  FlipFlopD d_flipflop7 (
    .clock(clock),
    .reset(reset),
    .data(data[7]),
    .saida(saida[7]),
    .saida_negada(saida_negada[7])
  );

endmodule
