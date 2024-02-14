-- bom dia
entity d_ff is
	port(
		clk, clr, d	: in bit;
		q				: buffer bit
	);
end d_ff;

architecture rtl of d_ff is
begin

	check_clock	: process(clk, clr)
	begin
		if(clr = '1') then
			q <= '0';
		elsif(clk'event and clk = '1') then
			q <= d;
		end if;
	end process;
	
end rtl;

	