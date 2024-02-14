-- Projeto somador de Nbits
-- Aula 06 - SEL0384
-- Autores:
--Bárbara Fernandes Madera - nº: 11915032 
--Johnny Caselato Guimarães - nº: 11915481 
-- Professor: Maximiliam Luppe
-- Data: 01/11/2023

--Definição da entidade reg
entity reg is
	generic(
		n : integer := 8   --Tamanho padrão do registrador é 8 bits
	);
	port(
		clk, en : in bit;				  --Entradas do clock e do enable
		d : in bit_vector(n-1 downto 0);  --Entrada de dados de tamanho n
		q : out bit_vector(n-1 downto 0)  --Saída de dados de tamanho n
	);
end reg;

--Arquitetura RTL para a entidade reg
architecture rtl of reg is
begin
	--Processo para verificar a borda de subida do clock
	check_clock	: process(clk)
	begin
		--Se houver uma borda de subida no clock e o enable estiver ativo
		if(clk'event and clk = '1' and en = '1') then
			q <= d;  		-- Na borda de subida do Clock, a saída Q recebe o valor de D			  		
		end if;
	end process;
end rtl;


