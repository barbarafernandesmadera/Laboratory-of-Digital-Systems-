-- bom dia
entity t_ff is
	port(
		clk, clr, t	: in bit;
		q				: buffer bit
	);
end t_ff;

architecture rtl of t_ff is
begin

	check_clock	: process(clk, clr)
	begin
		if(clr = '1') then
			q <= '0';
		elsif(clk'event and clk = '1') then
			q <=  t xor q;
		end if;
	end process;
	
end rtl;