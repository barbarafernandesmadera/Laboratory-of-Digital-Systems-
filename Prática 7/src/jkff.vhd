-- bom dia
entity jk_ff is
	port(
		clk, clr, j, k	: in bit;
		q					: buffer bit
	);
end jk_ff;

architecture rtl of jk_ff is
begin

	check_clock	: process(clk, clr)
	begin
		if(clr = '1') then
			q <= '0';
		elsif(clk'event and clk = '1') then
			q <=  (j and (not q)) or ((not k) and q);
		end if;
	end process;
	
end rtl;