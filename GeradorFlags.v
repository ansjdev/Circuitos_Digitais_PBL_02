module GeradorFlags(
    input  wire [7:0] resultado,
    input  wire       A_msb,
    input  wire       B_msb,
    input  wire       Cout,
    input  wire [2:0] operacao,
    output wire [2:0] flags // {Overflow, Carry, Zero}
);
    // ------------------------------------------------------
    // Flag Zero: ativa quando o resultado e completamente zero
    // ------------------------------------------------------
    wire or01, or23, or45, or67, or0123, or4567, or_all;

    or  (or01, resultado[0], resultado[1]);
    or  (or23, resultado[2], resultado[3]);
    or  (or45, resultado[4], resultado[5]);
    or  (or67, resultado[6], resultado[7]);

    or  (or0123, or01, or23);
    or  (or4567, or45, or67);
    or  (or_all, or0123, or4567);

    not (flags[0], or_all); // Zero = NOT(qualquer bit = 1)

    // ------------------------------------------------------
    // Flag Carry: ativa na soma se houve transporte extra
    // ------------------------------------------------------
    // Decodificador da operacao == 100
    wire nS2, nS1, nS0;
    wire s_add;

    not (nS2, operacao[2]);
    not (nS1, operacao[1]);
    not (nS0, operacao[0]);

    and (s_add, operacao[2], nS1, nS0); // 100 → ADD

    and (flags[1], s_add, Cout); // Carry = Cout somente se ADD

    // ------------------------------------------------------
    // Flag Overflow: detecta quando o resultado "estoura" o limite
    // ------------------------------------------------------
    // Para soma: quando os sinais sao iguais mas o resultado tem sinal diferente
    // Para subtracao: quando os sinais sao diferentes e o resultado tem sinal errado
    // ------------------------------------------------------

    wire nA, nB, nRes;
    not (nA, A_msb);
    not (nB, B_msb);
    not (nRes, resultado[7]);

    // Igualdade A == B → XNOR
    wire AeqB;
    xnor (AeqB, A_msb, B_msb);

    // Diferenca resultado[7] != A_msb → XOR
    wire ResDiffA;
    xor (ResDiffA, resultado[7], A_msb);

    // ADD overflow: AeqB & ResDiffA
    wire ovf_add;
    and (ovf_add, AeqB, ResDiffA);

    // SUB overflow: (A != B) & (resultado[7] != A)
    wire AneqB;
    xor (AneqB, A_msb, B_msb);

    wire ovf_sub;
    and (ovf_sub, AneqB, ResDiffA);

    // Seletores de operacao
    wire s_sub;
    and (s_sub, operacao[2], nS1, operacao[0]); // 101 → SUB

    // Overflow final = (ADD & ovf_add) | (SUB & ovf_sub)
    wire ovf_add_sel, ovf_sub_sel;
    and (ovf_add_sel, s_add, ovf_add);
    and (ovf_sub_sel, s_sub, ovf_sub);
    or  (flags[2], ovf_add_sel, ovf_sub_sel);

endmodule