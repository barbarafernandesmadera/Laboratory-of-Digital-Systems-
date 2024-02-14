entity MercurioIV_Reg is
	port(
		SW: in bit_vector(3 downto 0);
		KEY : in bit_vector(11 downto 0);
		DISP0_D : out bit_vector(7 downto 0)
	);
end MercurioIV_Reg;

architecture top of MercurioIV_Reg is
	signal q_out : bit_vector(3 downto 0);
	
begin
	reg_0 : work.reg
		generic map (n => 4)
		port map(clk => KEY(0), en => KEY(2),  d => SW, q => q_out);
		
	disp_0 : work.MercurioIV_decod
		port map(hexa => q_out, segments => DISP0_D(6 downto 0));
end top;