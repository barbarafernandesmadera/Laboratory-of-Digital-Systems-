--Bom dia

entity MercurioIV_FF is
	port(
		SW 	: in bit_vector(3 downto 0);
		KEY	: in bit_vector(11 downto 0);
		LEDM_C: out bit_vector(4 downto 0);
		LEDM_R: out bit_vector(7 downto 0)
	);
end MercurioIV_FF;


architecture top of MercurioIV_FF is

	signal LEDs	:	bit_vector(3 downto 1);

begin
	jkff_0	:	work.jk_ff port map(clk => KEY(0), clr => KEY(2), j => sw(3), k => SW(2), q => LEDs(1));
	dff_0		:	work.d_ff port map(clk => KEY(0), clr => KEY(2), d => sw(1), q => LEDs(2));
	tff_0		:	work.t_ff port map(clk => KEY(0), clr => KEY(2), t => sw(0),q => LEDs(3));
	
	LEDM_R <= "11111110";
	LEDM_c(0) <= '1';
	LEDM_C(1) <= not LEDs(1);
	LEDM_C(2) <= not LEDs(2);
	LEDM_C(3) <= not LEDs(3);
	LEDM_c(4) <= '1';
end top;