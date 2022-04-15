library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_round_GNJN4GDIEL is
	generic		( 			OUT_WIDTH_g : natural := 13;
			IN_WIDTH_g : natural := 31;
			PIPELINE_g : natural := 0;
			ROUNDING_TYPE_g : string := "TRUNCATE_LOW";
			SIGNED_g : natural := 1);

	port(
		clk : in std_logic;
		reset : in std_logic;
		datain : in std_logic_vector(30 downto 0);
		dataout : out std_logic_vector(12 downto 0);
		ena : in std_logic;
		user_aclr : in std_logic);		
end entity;


architecture beh of alt_dspbuilder_round_GNJN4GDIEL is
	signal reset_i : std_logic;
begin  -- architecture beh
  reset_i <= reset or user_aclr;
  -----------------------------------------------------------------------------
  -- truncate low
  -----------------------------------------------------------------------------

  trunc_low: if ROUNDING_TYPE_g = "TRUNCATE_LOW" or 
  				(ROUNDING_TYPE_g = "ROUND0" and SIGNED_g = 0) generate
  begin  -- generate trunc_low

  	trunc_low_no_pipeline : if PIPELINE_g = 0 generate
  	begin	--generate trunc_low_no_pipeline
         dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
    end generate trunc_low_no_pipeline;


	  trunc_low_pipelined: if PIPELINE_g = 1 generate
	  begin  -- generate trunc_low
	    trunc_low_p: process (clk, reset_i) is
	    begin  -- process trunc_low_p
	      if reset_i = '1' then                 -- asynchronous reset_i (active high)
	        dataout <= (others => '0');
	      elsif rising_edge(clk) then         -- rising clock edge
	        if ena = '1' then
	          dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
	        end if;
	      end if;
	    end process trunc_low_p;
	  end generate trunc_low_pipelined;

  end generate trunc_low;
  
  -----------------------------------------------------------------------------
  -- simple rounding (always rounds up)
  -----------------------------------------------------------------------------

  round     : if ROUNDING_TYPE_g = "ROUND_UP" or
  				 (ROUNDING_TYPE_g = "ROUND_UP_SYM" and SIGNED_g = 0) generate

  begin --generate round

	  round_no_pipeline     : if PIPELINE_g = 0 generate
	  begin  -- generate round_no_pipeline
	    -- get relevant bits
	    round_p  : process (datain) is
	    	variable RB : std_logic := '0';		-- rounding bit (MSB of discarded part)
	    begin	--process round_p
	    	 -- get relevant bits
	    	 RB  := datain(IN_WIDTH_g-OUT_WIDTH_g-1);  
	         if RB = '1' then
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
	          else
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
	          end if;
	     end process round_p;
	  end generate round_no_pipeline;
	  
	  round_pipelined     : if PIPELINE_g = 1 generate
	  	signal RB  : std_logic;               -- rounding bit (MSB of discarded part)
	  begin  -- generate round_pipelined
	  
	    -- get relevant bits
	    RB  <= datain(IN_WIDTH_g-OUT_WIDTH_g-1);
	   
	    round_p : process (clk, reset_i) is
	    begin  -- process round_p
	      if reset_i = '1' then               -- asynchronous reset_i (active high)
	        dataout   <= (others => '0');
	      elsif rising_edge(clk) then       -- rising clock edge
	        if ena = '1' then          
	          if RB = '1' then
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
	          else
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
	          end if;
	        end if;
	      end if;
	    end process round_p;
	  end generate round_pipelined;
end generate round;

  -----------------------------------------------------------------------------
  -- round towards 0
  -----------------------------------------------------------------------------
  round0 : if ROUNDING_TYPE_g = "ROUND0" and SIGNED_g = 1 generate
  begin  -- generate round0
  
  		round0_no_pipeline : if PIPELINE_g = 0 generate
  		begin	--generate round0_no_pipeline
  			 round0_p : process(datain) is
  			 	variable SB : std_logic := '0';
			 	variable OR_accu : std_logic := '0';
			 begin --process round0_p
			     SB  := datain(IN_WIDTH_g-1);
			     OR_accu := '0';
			     for i in 0 to IN_WIDTH_g-OUT_WIDTH_g-1 loop
			        OR_accu := OR_accu or datain(i);
			     end loop;  -- i
			     if SB = '1' and OR_accu = '1' then
			        dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
			     else
			        dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
			    end if;
		    end process round0_p;
	    end generate round0_no_pipeline;
	
	
	  round0_pipelined : if PIPELINE_g = 1 generate
	  	signal SB  : std_logic;               -- sign bit
	  begin  -- generate round0
	
		SB  <= datain(IN_WIDTH_g-1);
	
	    round0_p : process (clk, reset_i) is
	      variable OR_accu : std_logic := '0';
	    begin  -- process round0_p
	      if reset_i = '1' then               -- asynchronous reset_i (active high)
	        dataout   <= (others => '0');
	      elsif rising_edge(clk) then       -- rising clock edge
	        if ena = '1' then
	          OR_accu := '0';
	          for i in 0 to IN_WIDTH_g-OUT_WIDTH_g-1 loop
	            OR_accu := OR_accu or datain(i);
	          end loop;  -- i
	          if SB = '1' and OR_accu = '1' then
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
	          else
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
	          end if;
	        end if;
	      end if;
	    end process round0_p;
	  end generate round0_pipelined;
  end generate round0;

  -----------------------------------------------------------------------------
  -- round up symmetric
  -----------------------------------------------------------------------------
  round_up_sym : if ROUNDING_TYPE_g = "ROUND_UP_SYM" and SIGNED_g = 1 generate
  begin  -- generate round_up_sym

	    round_up_sym_no_pipeline : if PIPELINE_g = 0 generate
		begin --generate round_up_sym_no_pipeline
			round_up_sym_p : process (datain) is
				variable SB : std_logic := '0';		-- sign bit
				variable RB : std_logic := '0';		-- rounding bit (MSB of discarded part)
		      	variable OR_accu : std_logic := '0';
			begin	--process round_up_sym_p
				  SB  := datain(IN_WIDTH_g-1);
		    	  RB  := datain(IN_WIDTH_g-OUT_WIDTH_g-1);
		          OR_accu := '0';
		          for i in 0 to IN_WIDTH_g-OUT_WIDTH_g-2 loop
		            OR_accu := OR_accu or datain(i);
		          end loop;  -- i
		          if (SB = '0' and RB = '1') or (SB = '1' and RB = '1' and OR_accu='1') then
		            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
		          else
		            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
		          end if;
		     end process round_up_sym_p;
	     end generate round_up_sym_no_pipeline;
	
	  round_up_sym_pipelined : if PIPELINE_g = 1 generate
	  	signal SB  : std_logic;               -- sign bit
  		signal RB  : std_logic;               -- rounding bit (MSB of discarded part)
	  begin  -- generate round_up_sym
	
		SB  <= datain(IN_WIDTH_g-1);
	    RB  <= datain(IN_WIDTH_g-OUT_WIDTH_g-1);
	
	    round_up_sym_p : process (clk, reset_i) is
	      variable OR_accu : std_logic := '0';
	    begin  -- process round_up_sym_p
	      if reset_i = '1' then               -- asynchronous reset_i (active high)
	        dataout   <= (others => '0');
	      elsif rising_edge(clk) then       -- rising clock edge
	        if ena = '1' then
	          OR_accu := '0';
	          for i in 0 to IN_WIDTH_g-OUT_WIDTH_g-2 loop
	            OR_accu := OR_accu or datain(i);
	          end loop;  -- i
	          if (SB = '0' and RB = '1') or (SB = '1' and RB = '1' and OR_accu='1') then
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
	          else
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);
	          end if;
	        end if;
	      end if;
	    end process round_up_sym_p;
	  end generate round_up_sym_pipelined;

  end generate round_up_sym;
  -----------------------------------------------------------------------------
  -- convergent rounding
  -- We have to deal separately with the case where IN_WIDTH_g - OUT_WIDTH_g = 1
  -- because in this case the extra logic to test the bits after RB can be
  -- ignored.
  -----------------------------------------------------------------------------
  conv_round : if ROUNDING_TYPE_g = "CONV_ROUND" and (IN_WIDTH_g - OUT_WIDTH_g) > 1 generate
  begin		-- generate conv_round
  	conv_round_no_pipeline : if PIPELINE_g = 0 generate
	begin  -- generate conv_round_no_pipeline 
	    conv_round_p : process (datain) is
			variable LSB : std_logic := '0';		-- least significant retained bit
			variable RB  : std_logic := '0';		-- rounding bit (MSB of discarded bit)	    
			variable OR_accu : std_logic := '0';
	    begin  -- process conv_round_p
	      LSB := datain(IN_WIDTH_g-OUT_WIDTH_g);
	      RB := datain(IN_WIDTH_g-OUT_WIDTH_g-1);
          OR_accu := '0';
          
          for i in 0 to IN_WIDTH_g-OUT_WIDTH_g-2 loop
            OR_accu := OR_accu or datain(i);
          end loop;  -- i
          
          if RB = '1' and (LSB = '1' or OR_accu = '1') then
            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
          else
            dataout   <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);          
          end if;
	    end process conv_round_p;
	end generate conv_round_no_pipeline;
	    
  	conv_round_pipeline : if PIPELINE_g = 1 generate
	  signal LSB : std_logic;               -- least significant retained bit
	  signal RB  : std_logic;               -- rounding bit (MSB of discarded bit)
	
	begin  -- generate conv_round_pipeline
	    -- get relevant bits
	    RB  <= datain(IN_WIDTH_g-OUT_WIDTH_g-1);
	    LSB <= datain(IN_WIDTH_g-OUT_WIDTH_g);
	    
	    conv_round_p : process (clk, reset_i) is
	       variable OR_accu : std_logic := '0';
	    begin  -- process conv_round_p
	      if reset_i = '1' then               -- asynchronous reset_i (active high)
	        dataout     <= (others => '0');
	      elsif rising_edge(clk) then       -- rising clock edge
	        if ena = '1' then
	          OR_accu := '0';
	          for i in 0 to IN_WIDTH_g-OUT_WIDTH_g-2 loop
	            OR_accu := OR_accu or datain(i);
	          end loop;  -- i
	          if RB = '1' and (LSB = '1' or OR_accu = '1') then
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
	          else
	            dataout   <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);          
	          end if;
	        end if;
	     end if;
	    end process conv_round_p;
	end generate conv_round_pipeline;
  end generate conv_round;

conv_round_single_bit : if ROUNDING_TYPE_g = "CONV_ROUND" and (IN_WIDTH_g - OUT_WIDTH_g) = 1 generate
begin	-- generate conv_round_single_bit
	conv_round_single_bit_no_pipeline : if PIPELINE_g = 0 generate
	begin  -- generate conv_round_single_bit_no_pipeline
	    conv_round_p : process (datain) is
			variable LSB : std_logic := '0';	-- least significant retained bit
			variable RB  : std_logic := '0';	-- rounding bit (MSB of discarded bit)	    
	    begin  -- process conv_round_p
		  -- get relevant bits
		  RB  := datain(IN_WIDTH_g-OUT_WIDTH_g-1);
		  LSB := datain(IN_WIDTH_g-OUT_WIDTH_g);	    
		  
          if RB = '1' and LSB = '1' then
            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
          else
            dataout   <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);          
          end if;
	    end process conv_round_p;
	end generate conv_round_single_bit_no_pipeline;
	
	conv_round_single_bit_pipeline : if PIPELINE_g = 1 generate
	  signal LSB : std_logic;               -- least significant retained bit
	  signal RB  : std_logic;               -- rounding bit (MSB of discarded bit)
	
	begin  -- generate conv_round_single_bit_pipeline
	    -- get relevant bits
	    RB  <= datain(IN_WIDTH_g-OUT_WIDTH_g-1);
	    LSB <= datain(IN_WIDTH_g-OUT_WIDTH_g);
	    
	    conv_round_p : process (clk, reset_i) is
	    begin  -- process conv_round_p
	      if reset_i = '1' then               -- asynchronous reset_i (active high)
	        dataout     <= (others => '0');
	      elsif rising_edge(clk) then       -- rising clock edge
	        if ena = '1' then
	          if RB = '1' and LSB = '1' then
	            dataout <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g)+1;
	          else
	            dataout   <= datain(IN_WIDTH_g-1 downto IN_WIDTH_g-OUT_WIDTH_g);          
	          end if;
	        end if;
	     end if;
	    end process conv_round_p;
	end generate conv_round_single_bit_pipeline;
end generate conv_round_single_bit;
  -----------------------------------------------------------------------------
  -- error checking:
  --   Have we got a valid rounding mode?
  -----------------------------------------------------------------------------
  assert    (ROUNDING_TYPE_g = "ROUND_UP" or
             ROUNDING_TYPE_g = "ROUND0" or
             ROUNDING_TYPE_g = "ROUND_UP_SYM" or
             ROUNDING_TYPE_g = "CONV_ROUND" or
             ROUNDING_TYPE_g = "TRUNCATE_LOW"
             ) report "Please check your rounding type and its spelling.  Currently, we only support ROUND_UP, ROUND0, CONV_ROUND, and TRUNCATE_LOW" severity error;


end architecture beh;