class counter_scoreboard;
	
	mailbox mbx;
	int prev_data = 0;
	
	function new(mailbox mbx);
		$display("%0t counter_scoreboard Created", $time);
		
		this.mbx=mbx;
		
		fork
			compare();
		join_none
	endfunction: new
	
	task compare();
		counter_stimulus rcv_pkt;
			forever begin
			mbx.get (rcv_pkt);
			//$display("@%0t SCB_PKT :: %p", $time, rcv_pkt);
			
			if (rcv_pkt.reset == 0) begin
				if (rcv_pkt.enable == 1) begin
					if (rcv_pkt.load == 0) begin
						if (rcv_pkt.up_down == 1 && prev_data != 16'hFFFF) begin
							//if (rcv_pkt.data_out == prev_data+1) begin
							if (rcv_pkt.data_out != prev_data+1) begin
								/*$display("@%0t Up_count check :: Pass", $time);
							end
							else begin*/
								$display("@%0t Up_count check :: Fail || prev_data: %0d, current_data: %0d", $time, prev_data, rcv_pkt.data_out);
							end
						end
						else if (rcv_pkt.up_down == 1 && prev_data == 16'hFFFF) begin
							//if (rcv_pkt.data_out == 16'h0000) begin
							if (rcv_pkt.data_out != 16'h0000) begin
								/*$display("@%0t Overflow check :: Pass", $time);
							end
							else begin*/
								$display("@%0t Overflow check :: Fail || Overflowed_data: %0d", $time, rcv_pkt.data_out);
							end
						end
						else if (rcv_pkt.up_down == 0 && prev_data !=0) begin
							//if (rcv_pkt.data_out == prev_data-1) begin
							if (rcv_pkt.data_out != prev_data-1) begin
								/*$display("@%0t Down_count check :: Pass", $time);
							end
							else begin*/
								$display("@%0t Down_count check :: Fail || prev_data: %0d, current_data: %0d", $time, prev_data, rcv_pkt.data_out);
							end
						end
						else if (rcv_pkt.up_down == 0 && prev_data == 16'h0000) begin
							//if (rcv_pkt.data_out == 16'hFFFF) begin
							if (rcv_pkt.data_out != 16'hFFFF) begin
								/*$display("@%0t Underflow check :: Pass", $time);
							end
							else begin*/
								$display("@%0t Underflow check :: Fail || Underflowed_data: %0d", $time, rcv_pkt.data_out);
							end
						end
						prev_data= rcv_pkt.data_out;
					end
					else if (rcv_pkt.load == 1) begin
						prev_data= rcv_pkt.data_out;
						if (rcv_pkt.up_down == 1 || rcv_pkt.up_down == 0) begin
							//if(rcv_pkt.data_out==rcv_pkt.data_in) begin
							if(rcv_pkt.data_out!=rcv_pkt.data_in) begin
								/*$display("@%0t Load check :: Pass", $time);
							end
							else begin*/
								$display("@%0t Load check :: Fail || data_in= %0d, data_out= %0d", $time, rcv_pkt.data_in, rcv_pkt.data_out);
							end
						end
					end
					prev_data= rcv_pkt.data_out;
				end
				else if (rcv_pkt.enable == 0) begin
					if (rcv_pkt.data_out != prev_data) begin
						$display ("@%0t Enable check :: Fail || data_out = %0d, prev_data = %0d", $time, rcv_pkt.data_out, prev_data);
					end
					//else begin
						//$display ("@%0t Enable check :: Pass", $time);
					//end
				end
			end
			else if (rcv_pkt.reset == 1) begin
				//if (rcv_pkt.data_out == 0) begin
				if (rcv_pkt.data_out != 0) begin
					/*$display ("@%0t Reset check :: Pass", $time);
				end
				else begin*/
					$display ("@%0t Reset check :: Fail, data_out = %0d", $time, rcv_pkt);
				end
				prev_data=0;
			end
			end
	endtask
	
endclass