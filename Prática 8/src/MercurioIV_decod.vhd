-- Declaracao da ENTIDADE (entity)
-- 	Ela estabelece a interface do sistema digital com o mundo, ou seja, os pinos (sinais) de entrada e saida.
-- 	O nome da ENTIDADE deve ter tamanho maximo de 32 caracteres, sem pontuacao ou caracteres especiais.
-- 	Deve comecar por letra e pode incluir algarismos numericos e 'underline' (_).
-- 	O VHDL nao distingue entre maiuscula e minuscula ('case insensitive')
-- 
entity MercurioIV_decod is
	port
	(
		-- Portas
		-- A sintaxe eh: NOME_DA_PORTA : MODO (in, out, inout) TIPO (bit, boolean, character, integer, real, time, bit_vector, string);
		-- Entrada(s)
		hexa : in  bit_vector(3 downto 0);		-- Signal hexa do MODO de entrada (in) e do TIPO bit_vector de 4 bits

		-- Saida(s)
		segments : out bit_vector(6 downto 0)	-- Signal seg_a do MODO de saida (out) e do TIPO bit_vector de 7 bits
								-- A ultima declaracao de porta nao tem ponto e virgula (;)
	);
end MercurioIV_decod;

-- Declaracao da ARQUITETURA (architecture)
-- 	Ela estabelece a relacao entre os pinos de entrada e de saida, ou seja, o circuito a ser implementado.
-- 	O nome da ARQUITETURA deve ter tamanho maximo de 32 caracteres, sem pontuacao ou caracteres especiais.
-- 	Deve comecar por letra e pode incluir algarismos numericos e 'underline' (_).
-- 	Cada ENTIDADE pode ter mais de uma ARQUITETURA, assim e necessario distingui-las por meio de um nome.

architecture operadores of MercurioIV_decod is	-- ARQUITETURA 'operadores' associada aa ENTIDADE 'MercurioIV_decod'

	-- Sinais auxiliares que receberão o complemento de b3, b2, b1 e b0
	
	signal b3, b2, b1, b0, nb3, nb2, nb1, nb0: bit;

	-- Inicio da declaracao da ARQUITETURA

begin

	-- A atribuicao do valor para cada saida eh realizada por meio do operador atribuicao de sinal (<=)
	b3 <= hexa(3);
	b2 <= hexa(2);
	b1 <= hexa(1);
	b0 <= hexa(0);
	nb3 <= not b3;
	nb2 <= not b2;
	nb1 <= not b1;
	nb0 <= not b0;

	 --Para cada uma das saidas sera atribuida uma expressao booleana baseada nos operadores logicos E (and) OU (or) e NAO (not).
	segments(0) <= (b3 or b2 or b1 or nb0) and (b3 or nb2 or b1 or b0) and (nb3 or nb2 or b1 or nb0) and (nb3 or b2 or nb1 or nb0); -- Escrita na forma de produto de somas
	segments(1) <= (nb3 and nb2) or (nb2 and nb0) or (nb3 and nb1 and nb0) or (nb3 and b1 and b0) or (b3 and nb1 and b0);
	segments(2) <= (b3 or b2 or nb1 or b0) and (nb3 or nb2 or b1 or b0) and (nb3 or nb2 or nb1);
	segments(3) <= (b3 or b2 or b1 or nb0) and (b3 or nb2 or b1 or b0) and (nb3 or b2 or nb1 or b0) and (nb2 or nb1 or nb0);
	segments(4) <= (nb2 and nb0) or (b3 and b2) or (b1 and nb0) or (b3 and b1);
	segments(5) <= (nb1 and nb0) or (b3 and nb2) or (b3 and b1) or (nb3 and b2 and nb1) or (nb3 and b2 and nb0);
	segments(6) <= (b3 or b2 or b1) and (nb3 or nb2 or b1 or b0) and (b3 or nb2 or nb1 or nb0);
	
end operadores;
