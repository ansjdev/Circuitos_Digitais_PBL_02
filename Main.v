module Main(    
	 input clock,
    input reset,              // Reset ativo alto
    input botao,              // Botão para transição de estados
    
    // Saídas que mostram a diferenciação
    output Led_Estado_00,     // Ativo apenas no estado 00
    output Led_Estado_01,     // Ativo apenas no estado 01
    output Led_Estado_10      // Ativo apenas no estado 10
);

    // --- SINAIS INTERNOS ---
    
    // Fio que conecta o contador ao decodificador
    wire [1:0] estado_atual_contador;
    
    // (Os fios de saída do decodificador são os próprios 
    //  portas de saída 'Led_Estado_...')

    // --- LÓGICA ESTRUTURAL ---

    // 1. Instancia o Contador de Estados
    // Ele gera a sequência 00, 01, 10
    ContadorEstados meu_contador (
        .clock(clock),
        .reset(reset),
        .botao(botao),
        .estado_atual(estado_atual_contador) // Saída [1:0]
    );

    // 2. Instancia o Decodificador de Estado
    // Ele "lê" a saída do contador e ativa o LED correspondente
    DecodificadorDeEstado meu_decodificador (
        .estado(estado_atual_contador), // Conecta a saída do contador
        .Y0_00(Led_Estado_00),          // Conecta na saída do estado 00
        .Y1_01(Led_Estado_01),          // Conecta na saída do estado 01
        .Y2_10(Led_Estado_10)           // Conecta na saída do estado 10
    );
    
endmodule