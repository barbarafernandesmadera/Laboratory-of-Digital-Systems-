-- Projeto somador de Nbits
-- Aula 06 - SEL0384
-- Autores:
--Bárbara Fernandes Madera - nº: 11915032 
--Johnny Caselato Guimarães - nº: 11915481 
-- Professor: Maximiliam Luppe
-- Data: 01/11/2023

--Definição da entrada MercurioIV_Reg com as portas de entrada e saída
entity MercurioIV_Reg is
	port(
		SW: in bit_vector(3 downto 0);		--Entrada dos switches
		KEY : in bit_vector(11 downto 0);	--Entrada dos botões
		DISP0_D : out bit_vector(7 downto 0) --Saída para o display de 7 segmentos
	);
end MercurioIV_Reg;

--Definição da arquitetura top para a entidade MercurioIV_Reg
architecture top of MercurioIV_Reg is
	signal q_out : bit_vector(3 downto 0);  --Declaração do sinal interno q_out
	
begin
	--Instanciação do registrador de 4 bits do tipo work.reg
	reg_0 : work.reg
		generic map (n => 4)  --Definição do tamanho do registrador (4 bits)
		port map(clk => KEY(0), en => KEY(2),  d => SW, q => q_out);
		--Mapeamento das portas: clock (KEY(0)), enable (KEY(2)), dados (SW) e saída (q_out)

	--Instaciação do decodificador MercurioIV_decod
	disp_0 : work.MercurioIV_decod
		port map(hexa => q_out, segments => DISP0_D(6 downto 0));
		--Mapeamento das portas: entrada em hexadecimal (q_out) e saída para os segmentos do display de 7 segmentos (DISPO_D)
end top;


