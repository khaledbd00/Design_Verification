interface counter_interface;//(input bit clk);
	bit clk;
	logic [15:0] data_in;
	logic load;
	logic reset;
	logic enable;
	logic up_down;
	logic [15:0] data_out;

endinterface