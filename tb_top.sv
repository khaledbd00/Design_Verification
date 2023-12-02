module tb_top;

   import tb_package::*;
   bit clk;

//clock generation
initial begin
	forever #10 clk =~ clk;
end

//interface instance
counter_interface count_intf(clk);

//DUT instantiation
counter DUT(
.data_in(count_intf.data_in),
.load(count_intf.load),
.reset(count_intf.reset),
.up_down(count_intf.up_down),
.enable(count_intf.enable),
.clk(count_intf.clk),
.data_out(count_intf.data_out)
);

//Run simulation from test
counter_test test_obj;

initial begin

	test_obj = new(count_intf);
	test_obj.run_phase();
	#100 $display("%0t simulation finished", $time);
	$finish();
end
endmodule
