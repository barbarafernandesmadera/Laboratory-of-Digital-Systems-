-- Projeto somador de Nbits
-- Aula 06 - SEL0384
-- Autores:
--Bárbara Fernandes Madera - nº: 11915032 
--Johnny Caselato Guimarães - nº: 11915481 
-- Professor: Maximiliam Luppe
-- Data: 01/11/2023

entity d_ff is
	port(
	 clk, clr, d	: in bit;  -- Entradas do flip-flop: Clock, Clear e Dado
	 q : buffer bit  -- Saída do flip-flop: Q
	);
end d_ff;

architecture rtl of d_ff is
begin
	check_clock	: process(clk, clr)
	begin
		if(clr = '1') then
			q <= '0';  -- Se Clear estiver ativo, a saída Q é definida como 0
		elsif (clk'event and clk = '1') then
			q <= d;  -- Na borda de subida do Clock, a saída Q recebe o valor de D
		end if;
	end process;
end rtl;
