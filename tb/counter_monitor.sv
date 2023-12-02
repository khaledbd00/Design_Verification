class counter_monitor;
	virtual counter_interface count_intf;
	mailbox mbx;
	
	function new( virtual counter_interface count_intf, mailbox mbx);
		$display("%0t Counter monitor generated", $time);
		this.count_intf = count_intf;
		this.mbx = mbx;
			fork
			monitor_capture();
			join_none
	endfunction :new
	
	task monitor_capture();
	
		counter_stimulus pkt;
			forever begin
			@(negedge count_intf.clk);
			pkt = new();
			
			pkt.data_in = count_intf.data_in;
			pkt.load = count_intf.load;
			pkt.enable = count_intf.enable;
			pkt.reset = count_intf.reset;
			pkt.up_down = count_intf.up_down;
			pkt.data_out = count_intf.data_out;
			
			//$display ("@%0t MNTR_PKT :: %p", $time,pkt);
			mbx.put(pkt);
			end
	endtask
endclass