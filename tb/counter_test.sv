class counter_test;

	counter_environment env_obj;
	
	function new(virtual counter_interface count_intf);
			$display ("%0t Counter Test Running",$time);
		env_obj = new(count_intf);
	endfunction : new
	task run_phase();
	
		env_obj.agnt_obj.drv_obj.reset();
		repeat(40) env_obj.agnt_obj.drv_obj.load($urandom(),$urandom_range(1,0),$urandom_range(1,0),$urandom_range(1,0));
		env_obj.agnt_obj.drv_obj.load(16'hFFFF,1,0,1);
		repeat(20)env_obj.agnt_obj.drv_obj.up_down(16'hFFFF,1);
		repeat(100)env_obj.agnt_obj.drv_obj.up_down($urandom(),$urandom_range(1,0));
		repeat(50) env_obj.agnt_obj.drv_obj.load($urandom(),$urandom_range(1,0),0);
		repeat(100)env_obj.agnt_obj.drv_obj.up_down($urandom(),$urandom_range(1,0));
	endtask
endclass