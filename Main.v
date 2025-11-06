module Main(    
	input clock,
    input reset,              // Reset ativo alto
    input botao,              // Botão para transição de estados
    output [1:0] estado_atual,// Estado atual (00, 01 ou 10)
    output led_bit0,          // LED para bit 0 do estado (LSB)
    output led_bit1           // LED para bit 1 do estado (MSB)
);

    // Registrador de estado
    wire [1:0] estado_reg;
    wire [1:0] proximo_estado;
    wire [1:0] estado_negado;
    wire reset_interno;
    not (reset_interno, reset);  // Inverte reset (FlipFlopD usa reset ativo baixo)
    
    FlipFlopD2Bits registrador_estado (
        .clock(clock),
        .reset(reset_interno),
        .data(proximo_estado),
        .saida(estado_reg),
        .saida_negada(estado_negado)
    );
    
    // Detecção do estado atual
    wire estado_00, estado_01, estado_10;
    and (estado_00, estado_negado[1], estado_negado[0]);  // Estado 00
    and (estado_01, estado_negado[1], estado_reg[0]);     // Estado 01
    and (estado_10, estado_reg[1], estado_negado[0]);     // Estado 10
    
    // Cálculo das transições (somadores/subtratores)
    wire [1:0] soma_00_01, soma_01_10, sub_10_01;
    wire Cout_00, Cout_01, Bout_10;
    
    Somador2Bits somador_00_01 (.A(estado_reg), .B(2'b01), .Cin(1'b0), .S(soma_00_01), .Cout(Cout_00));  // 00→01
    Somador2Bits somador_01_10 (.A(estado_reg), .B(2'b01), .Cin(1'b0), .S(soma_01_10), .Cout(Cout_01));  // 01→10
    Subtrator2Bits subtrator_10_01 (.A(estado_reg), .B(2'b01), .Bin(1'b0), .S(sub_10_01), .Bout(Bout_10));  // 10→01
    
    // Sinais auxiliares
    wire botao_negado, reset_negado;
    not (botao_negado, botao);
    not (reset_negado, reset);
    
    // Detecção de transições (estado atual E botão pressionado)
    wire transicao_00_01, transicao_01_10, transicao_10_01;
    and (transicao_00_01, estado_00, botao);
    and (transicao_01_10, estado_01, botao);
    and (transicao_10_01, estado_10, botao);
    
    // Seleção do próximo estado (bit 0)
    wire [1:0] prox_00_01, prox_01_10, prox_10_01, prox_mantem;
    and (prox_00_01[0], reset_negado, transicao_00_01, soma_00_01[0]);  // Se 00→01: usa bit0 de soma_00_01
    and (prox_00_01[1], reset_negado, transicao_00_01, soma_00_01[1]);  // Se 00→01: usa bit1 de soma_00_01
    and (prox_01_10[0], reset_negado, transicao_01_10, soma_01_10[0]);  // Se 01→10: usa bit0 de soma_01_10
    and (prox_01_10[1], reset_negado, transicao_01_10, soma_01_10[1]);  // Se 01→10: usa bit1 de soma_01_10
    and (prox_10_01[0], reset_negado, transicao_10_01, sub_10_01[0]);   // Se 10→01: usa bit0 de sub_10_01
    and (prox_10_01[1], reset_negado, transicao_10_01, sub_10_01[1]);   // Se 10→01: usa bit1 de sub_10_01
    and (prox_mantem[0], reset_negado, botao_negado, estado_reg[0]);   // Se botão não pressionado: mantém bit0
    and (prox_mantem[1], reset_negado, botao_negado, estado_reg[1]);    // Se botão não pressionado: mantém bit1
    
    // Combinação das possibilidades (portas OR)
    // Agrupa as 4 possibilidades em 2 grupos para cada bit
    wire prox_bit0_grupo1, prox_bit0_grupo2;  // Grupos temporários do bit 0
    wire prox_bit1_grupo1, prox_bit1_grupo2;  // Grupos temporários do bit 1
    
    or (prox_bit0_grupo1, prox_00_01[0], prox_01_10[0]);  // Bit0: transições 00→01 ou 01→10
    or (prox_bit0_grupo2, prox_10_01[0], prox_mantem[0]); // Bit0: transição 10→01 ou mantém
    or (prox_bit1_grupo1, prox_00_01[1], prox_01_10[1]);  // Bit1: transições 00→01 ou 01→10
    or (prox_bit1_grupo2, prox_10_01[1], prox_mantem[1]); // Bit1: transição 10→01 ou mantém
    
    // Combina os 2 grupos em resultado final para cada bit
    wire prox_bit0_final, prox_bit1_final;  // Valores finais quando reset não está ativo
    or (prox_bit0_final, prox_bit0_grupo1, prox_bit0_grupo2);  // Bit0 final
    or (prox_bit1_final, prox_bit1_grupo1, prox_bit1_grupo2);  // Bit1 final
    
    // Prioridade do reset (se reset=1, força próximo_estado=00)
    wire prox_bit0_reset, prox_bit1_reset;  // Valores quando reset está ativo (sempre 0)
    and (prox_bit0_reset, reset, 1'b0);
    and (prox_bit1_reset, reset, 1'b0);
    
    // Seleção final: reset tem prioridade sobre lógica normal
    or (proximo_estado[0], prox_bit0_reset, prox_bit0_final);
    or (proximo_estado[1], prox_bit1_reset, prox_bit1_final);
    
    // Saída
    buf (estado_atual[0], estado_reg[0]);
    buf (estado_atual[1], estado_reg[1]);
    
    // Saídas para LEDs
    buf (led_bit0, estado_reg[0]);  // LED 0: bit menos significativo (LSB)
    buf (led_bit1, estado_reg[1]);  // LED 1: bit mais significativo (MSB)
    
endmodule
