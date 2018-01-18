import uvm_pkg::*;
import tb_pkg::*;

module top();

	dut_interface dut_if();

	initial begin
		uvm_config_db #(virtual dut_interface)::set(null, "*", "dut_interface", dut_if);
		run_test();
		//run_test("test1");
	end

endmodule : top


