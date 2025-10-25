module FlipFlopD (
  input clock, reset,
  input data,
  output reg saida, 
  output saida_negada
  );
  
  always@(posedge clock or negedge reset)
  begin
    if(!reset) saida <= 0;
    else begin
      saida <= data;
    end
  end
  assign saida_negada = ~saida;
endmodule