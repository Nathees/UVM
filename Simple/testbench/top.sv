import uvm_pkg::*;
import tb_pkg::*;

module top();

	adder_interface add_if();
	adder_wrapper add_inst(add_if);

	initial begin
		uvm_config_db #(virtual adder_interface)::set(null, "*", "adder_interface", add_if);
		run_test();
		//run_test("test1");
	end

endmodule : top


