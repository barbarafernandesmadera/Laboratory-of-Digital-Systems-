entity MercurioIV_Golden_Top is
	port
	(
		DISP0_D	: out bit_vector(7 downto 0);

		SW			: in bit_vector(3 downto 0);
		SA, SB	: in bit_vector(7 downto 0);

		LED_R 	: out bit
	);

end MercurioIV_Golden_Top;


architecture top of MercurioIV_Golden_Top is

	signal ALUResult: bit_vector(3 downto 0);

begin

	-- Component Instantiation Statement
	
	ALU0: work.MercurioIV_ALU
		port map (
			A => SA(3 downto 0), B => SB(3 downto 0), ALUControl => SW(2 downto 0), 
			Result => ALUResult, Zero => LED_R
		);

	display0: work.MercurioIV_decod
		port map (
			hexa => ALUResult, 
			segments => DISP0_D(6 downto 0)
		);

end top;
