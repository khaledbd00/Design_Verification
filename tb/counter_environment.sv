class counter_environment;

	counter_scoreboard scb_obj;
	counter_agent agnt_obj;
	mailbox mbx;
	
	function new(virtual counter_interface count_intf);
			$display("%0t counter environment running", $time);
		mbx = new();
		scb_obj = new(.mbx(mbx));
		agnt_obj = new(.count_intf(count_intf), .mbx(mbx));
	endfunction: new
endclass