class counter_driver;

	virtual counter_interface count_intf;
	
		function new(virtual counter_interface count_intf);
			$display("%0t Counter driver generated", $time);
			this.count_intf = count_intf;
		endfunction
		
			task reset();
				count_intf.load <= 0;
				count_intf.enable <= 0;
				count_intf.reset <= 0;
				count_intf.data_in <= 0;
				count_intf.up_down <= 0;
				@(negedge count_intf.clk)
				count_intf.reset <= 1;
				@(negedge count_intf.clk)
				count_intf.reset <= 0;
			endtask
			
			task load(logic [15:0] data_in=4'h0, bit load = 1, bit up_down=0, bit enable=0);
				@(negedge count_intf.clk)
				count_intf.load <= load;
				count_intf.data_in <= data_in;
				count_intf.enable <= enable;
				count_intf.up_down <= up_down;
			endtask
			
			task up_down(logic [15:0] data_in=4'h0, bit up_down);
				@(negedge count_intf.clk)
				count_intf.load <= 0;
				count_intf.data_in <= data_in;
				count_intf.enable <= 1;
				count_intf.up_down <= up_down;
			endtask
endclass