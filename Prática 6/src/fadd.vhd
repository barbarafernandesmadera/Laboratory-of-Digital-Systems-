-- Projeto somador de 4bits
-- Aula 05 - SEL0384
-- Autores:
--
--
-- Professor: Maximiliam Luppe
-- Data: 27/09/2023

entity fadd is
	port
		(
			a, b, ci	: in bit;
			s, co		: out bit
		);
end fadd;

architecture concorrente of fadd is
begin

	-- implementacao da saida s
	s <= a xor b xor ci;
	
	-- implementacao da saida co
	co <= (a and (b or ci)) or (b and ci);

end;

		