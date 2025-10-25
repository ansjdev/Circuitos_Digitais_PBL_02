module Bin8toBCD3Dig_Assign(
    input  [7:0] D,       // Entrada 8 bits (0-255)
    output [3:0] C,       // Centena
    output [3:0] Dd,      // Dezena
    output [3:0] U        // Unidade
);

    // Conversão direta usando assign
    assign C  = D / 100;         // centena
    assign Dd = (D % 100) / 10;  // dezena
    assign U  = D % 10;          // unidade

endmodule