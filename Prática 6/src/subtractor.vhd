entity subtractor is
	port
	(
    	A, B    	: in bit_vector(3 downto 0);
    	Cin     	: bit;
    	RESULT  	: out bit_vector(3 downto 0);
		Negative	: out bit
	);
end subtractor;

architecture hierarquia of subtractor is
	signal C 	: bit_vector(3 downto 1);
	signal B_complement	: bit_vector(3 downto 0);

begin
	-- Inverter os bits de B para realizar a subtração
	B_complement <= not B;
	
	fa0: work.fadd port map (a => A(0), b => B_complement(0), ci =>  Cin, s => RESULT(0), co => C(1));
	fa1: work.fadd port map (a => A(1), b => B_complement(1), ci => C(1), s => RESULT(1), co => C(2));
	fa2: work.fadd port map (a => A(2), b => B_complement(2), ci => C(2), s => RESULT(2), co => C(3));
	fa3: work.fadd port map (a => A(3), b => B_complement(3), ci => C(3), s => RESULT(3), co => Negative);
end;
