// Módulo: ContadorEstados.v (Altera entre os estados 00 -> 01 <-> 10)

module ContadorEstados(
    input clock,
    input reset,              // Reset ativo alto
    input botao,              // Botão para transição de estados
    output [1:0] estado_atual // Estado atual (00, 01 ou 10)
);

    // --- SINAIS INTERNOS ---

    // Fio único para reset invertido (ativo-baixo)
    wire reset_inv;

    // Fios para o Registrador de Estado
    wire [1:0] estado_reg;
    wire [1:0] proximo_estado;
    wire [1:0] estado_negado;

    // Fios para Detecção de Borda (CORREÇÃO 1)
    wire botao_last;
    wire botao_last_negado;
    wire botao_pressed;         // Pulso de 1 ciclo na borda de subida
    wire botao_pressed_negado;  // Inversão do pulso

    // Fios para Decodificação de Estado
    wire estado_00, estado_01, estado_10;

    // Fios para Lógica Aritmética
    wire [1:0] soma_mais_um;   // somador para 00->01 e 01->10
    wire [1:0] sub_menos_um;   // subtrator para 10 -> 01
    wire Cout_soma, Bout_sub;

    // Fios para Lógica de Transição
    wire transicao_00_01, transicao_01_10, transicao_10_01;
    
    // Fios para o MUX Estrutural
    wire [1:0] prox_00_01, prox_01_10, prox_10_01, prox_mantem;


    // --- LÓGICA ESTRUTURAL ---

    // 'reset_inv' = 0 quando reset=1 (ativo)
    not (reset_inv, reset); 
    
    // 2. Detecção de Borda de Subida do Botão
    FlipFlopD ff_botao (
        .clock(clock),
        .reset(reset_inv), // FFs usam reset ativo-baixo
        .data(botao),
        .saida(botao_last),
        .saida_negada(botao_last_negado)
    );
    // Gera o pulso 'botao_pressed'
    and (botao_pressed, botao, botao_last_negado);
    // Gera a negação do pulso (para a lógica de manutenção)
    not (botao_pressed_negado, botao_pressed);

    
    // 3. Registrador de Estado (Salva o estado atual)
    FlipFlopD2Bits registrador_estado (
        .clock(clock),
        .reset(reset_inv), // FFs usam reset ativo-baixo
        .data(proximo_estado),
        .saida(estado_reg),   
        .saida_negada(estado_negado)
    );

    // 4. Decodificador de Estado (Verifica "onde estamos")
    and (estado_00, estado_negado[1], estado_negado[0]); // 00
    and (estado_01, estado_negado[1], estado_reg[0]);    // 01
    and (estado_10, estado_reg[1], estado_negado[0]);    // 10
    
    // 5. Lógica Aritmética para os próximos estados
    Somador2Bits somador_unico (.A(estado_reg), .B(2'b01), .Cin(1'b0), .S(soma_mais_um), .Cout(Cout_soma));
    Subtrator2Bits subtrator_unico (.A(estado_reg), .B(2'b01), .Bin(1'b0), .S(sub_menos_um), .Bout(Bout_sub));
    
    // 6. Lógica de Transição (Verifica se há mudança de estado e qual mudança é)
    and (transicao_00_01, estado_00, botao_pressed);
    and (transicao_01_10, estado_01, botao_pressed);
    and (transicao_10_01, estado_10, botao_pressed);
    
    // 7. MUX Estrutural (Seletores AND)
    // O 'reset_inv' (ativo-baixo) desliga todos os caminhos se reset=1.
    
    // Caminho 00 -> 01
    and (prox_00_01[0], reset_inv, transicao_00_01, soma_mais_um[0]); 
    and (prox_00_01[1], reset_inv, transicao_00_01, soma_mais_um[1]); 

    // Caminho 01 -> 10
    and (prox_01_10[0], reset_inv, transicao_01_10, soma_mais_um[0]); 
    and (prox_01_10[1], reset_inv, transicao_01_10, soma_mais_um[1]); 

    // Caminho 10 -> 01
    and (prox_10_01[0], reset_inv, transicao_10_01, sub_menos_um[0]);  
    and (prox_10_01[1], reset_inv, transicao_10_01, sub_menos_um[1]);  
    
    // Caminho de Manutenção (CORREÇÃO 2: USA 'botao_pressed_negado')
    // Ativo se (reset=0) E (NENHUM pulso de botão)
    // Se o estado for '11', este caminho é ativado (pois transicao...=0),
    // mas 'botao_pressed_negado'=1, e ele mantém '11'.
    // SE o botão for pressionado em '11', 'botao_pressed_negado'=0,
    // este caminho DESLIGA. Como todos os outros caminhos também
    // estão desligados (pois estado_00/01/10=0), o MUX (OR)
    // resulta em 00, recuperando o circuito.
    and (prox_mantem[0], reset_inv, botao_pressed_negado, estado_reg[0]);
    and (prox_mantem[1], reset_inv, botao_pressed_negado, estado_reg[1]);   
    
    // 8. MUX Estrutural (Agrupador OR)
    // Combina os 4 caminhos. Se todos forem 0 (reset ou '11'+botao),
    // o resultado é 00.
    
    or (proximo_estado[0], prox_00_01[0], prox_01_10[0], prox_10_01[0], prox_mantem[0]);
    or (proximo_estado[1], prox_00_01[1], prox_01_10[1], prox_10_01[1], prox_mantem[1]);
    
    // 9. Saída
    // Expõe o estado salvo no registrador
    buf (estado_atual[0], estado_reg[0]);
    buf (estado_atual[1], estado_reg[1]);
    
endmodule