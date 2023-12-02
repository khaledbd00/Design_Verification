class counter_agent;

	counter_driver drv_obj;
	counter_monitor mntr_obj;
	
	function new(virtual counter_interface count_intf, mailbox mbx);
		$display("%0t counter_agent created",$time);
		
		drv_obj = new(count_intf);
		mntr_obj = new(count_intf, mbx);
	
	endfunction : new
endclass
		