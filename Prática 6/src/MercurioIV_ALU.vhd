-- Declaracao da ENTIDADE (entity)
-- 	Ela estabelece a interface do sistema digital com o mundo, ou seja, os pinos (sinais) de entrada e saida.
-- 	O nome da ENTIDADE deve ter tamanho maximo de 32 caracteres, sem pontuacao ou caracteres especiais.
-- 	Deve comecar por letra e pode incluir algarismos numericos e 'underline' (_).
-- 	O VHDL nao distingue entre maiuscula e minuscula ('case insensitive')
-- 
entity MercurioIV_ALU is
	port
	(
		-- Portas
		-- A sintaxe eh: NOME_DA_PORTA : MODO (in, out, inout) TIPO (bit, boolean, character, integer, real, time, bit_vector, string);
		-- Entrada(s)
		A, B			: in  bit_vector(3 downto 0);	-- Signals A e B do MODO de entrada (in) e do TIPO bit_vector
		ALUControl	: in  bit_vector(2 downto 0);		-- Signal ALUControl do MODO de entrada (in) e do TIPO bit_vector

		-- Saida(s)
		Result		: out bit_vector(3 downto 0);	-- Signal Result do MODO de saida (out) e do TIPO bit_vector de tamanho 3
		Zero			: out bit 							-- Signal Zero de MODO de saída (out) e do tipo bit
						-- A ultima declaracao de porta nao tem ponto e virgula (;)
	);
end MercurioIV_ALU;

-- Declaracao da ARQUITETURA (architecture)
-- 	Ela estabelece a relacao entre os pinos de entrada e de saida, ou seja, o circuito a ser implementado.
-- 	O nome da ARQUITETURA deve ter tamanho maximo de 32 caracteres, sem pontuacao ou caracteres especiais.
-- 	Deve comecar por letra e pode incluir algarismos numericos e 'underline' (_).
-- 	Cada ENTIDADE pode ter mais de uma ARQUITETURA, assim e necessario distingui-las por meio de um nome.

architecture estrutural of MercurioIV_ALU is	-- ARQUITETURA 'estrutural' associada aa ENTIDADE 'MercurioIV_ALU'
	
	-- Inicio da declaracao da ARQUITETURA
	
	signal Result_soma	: bit_vector(3 downto 0);
	signal Result_sub		: bit_vector(3 downto 0);
	signal Result_and		: bit_vector(3 downto 0);
	signal Result_or		: bit_vector(3 downto 0);
	signal SLT				: bit;
	signal Result_SLT		: bit_vector(3 downto 0);
	signal Result_aux		: bit_vector(3 downto 0);
	
begin

	adder_0			: work.adder port map(A => A(3 downto 0), B => B(3 downto 0), Cin => ALUControl(0), Result => Result_soma(3 downto 0));
	subtractor_0	: work.subtractor port map(A => A(3 downto 0), B => B(3 downto 0), Cin => ALUControl(0), Result => Result_sub(3 downto 0), Negative => SLT);
	
	Result_and(0) <= (A(0) and B(0));
	Result_and(1) <= (A(1) and B(1));
	Result_and(2) <= (A(2) and B(2));
	Result_and(3) <= (A(3) and B(3));
	
	Result_or(0) <= (A(0) or B(0));
	Result_or(1) <= (A(1) or B(1));
	Result_or(2) <= (A(2) or B(2));
	Result_or(3) <= (A(3) or B(3));
	
	Result_SLT(0) <= not SLT;
	
	Result <= Result_aux;
	
	with ALUControl select
		Result_aux <=	Result_soma when "000",
							Result_sub 	when "001",
							Result_and 	when "010",
							Result_or 	when "011",
							Result_SLT 	when "101",
							"0000" when others;
	
	Verificar_Zero: process(Result_aux)
	begin
		if Result_aux = "0000" then
			Zero <= '1';
		else
			Zero <= '0';
		end if;
	end process;
	
	-- Para a implementacao da arquitetura da ALU, recomenda-se o uso da construção concorrente "Selected Signal Assignment":
	--<optional_label>: with <expression> select
	--<target> <= <value> when <choices>
	--			  <value> when <choices>
	--			  <value> when <choices>
	-- 		      ...
	--			  <value> when others;
	--tendo como <target> Result (ou Result_tmp), e como <expression> ALUControl
	
	-- Dicas:
	-- Como o resultado da operacao SLT e a saida ZERO depende de Result, recomenda-se criar um sinal intermediario (Result_tmp)
	--que armazena o valor das operacoes aritmetica e lógicas, ou zero para as operacoes nao definidas. Lembre-se de que para a
	--operacao SLT eh necessario calcular A-B para verificar se A eh menor do que B.
	-- Depois, utiliza-se Result_tmp para definir o valor final de Result e de Zero.
	-- O valor de ZeroExt pode ser obtido por (0 => Result_tmp(WIDTH-1), others => '0')
	
end estrutural;
