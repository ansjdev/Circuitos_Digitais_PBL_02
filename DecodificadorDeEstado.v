module DecodificadorDeEstado(
    input  [1:0] estado,  // Entrada de 2 bits (vem do contador)
    output       Y0_00,   // Saída "Enable" para o estado 00
    output       Y1_01,   // Saída "Enable" para o estado 01
    output       Y2_10    // Saída "Enable" para o estado 10
);

    // --- SINAIS INTERNOS ---
    wire nS0, nS1; // Negação dos bits de estado

    // --- LÓGICA ESTRUTURAL ---

    // 1. Inversores
    not (nS0, estado[0]); // Negação do bit 0
    not (nS1, estado[1]); // Negação do bit 1

    // 2. Decodificador (Portas AND)

    // Saída Y0_00: Ativa em estado = 00 (nS1 e nS0)
    and (Y0_00, nS1, nS0);

    // Saída Y1_01: Ativa em estado = 01 (nS1 e estado[0])
    and (Y1_01, nS1, estado[0]);

    // Saída Y2_10: Ativa em estado = 10 (estado[1] e nS0)
    and (Y2_10, estado[1], nS0);

endmodule