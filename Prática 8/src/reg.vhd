--bom dia
entity reg is
	generic(
		n : integer := 8
	);
	port(
		clk, en : in bit;
		d : in bit_vector(n-1 downto 0);
		q : out bit_vector(n-1 downto 0)
	);
end reg;

architecture rtl of reg is
begin
	check_clock	: process(clk)
	begin
		if(clk'event and clk = '1' and en = '1') then
			q <= d;  		-- Na borda de subida do Clock, a saída Q recebe o valor de D			  		
		end if;
	end process;
end rtl;