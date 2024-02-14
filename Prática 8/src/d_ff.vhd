entity d_ff is
	port(
	 clk, clr, d	: in bit;  -- Entradas do flip-flop: Clock, Clear e Dado
	 q : buffer bit  -- Saída do flip-flop: Q
	);
end d_ff;

architecture rtl of d_ff is
begin
	check_clock	: process(clk, clr)
	begin
		if(clr = '1') then
			q <= '0';  -- Se Clear estiver ativo, a saída Q é definida como 0
		elsif (clk'event and clk = '1') then
			q <= d;  -- Na borda de subida do Clock, a saída Q recebe o valor de D
		end if;
	end process;
end rtl;
