class trans1 extends uvm_sequence_item;

	logic [16:0] sum;
	rand bit [15:0] data_1;
	rand bit [15:0] data_2;
	rand bit rst_n;

	`uvm_object_utils_begin(trans1)
	`uvm_field_int(sum, UVM_ALL_ON)
	`uvm_field_int(data_1, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(data_2, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(rst_n, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_object_utils_end

	function new (string name="trans1");
		super.new(name);
	endfunction

	function string convert2string();
		string s;
		s = $sformatf("sum=%4h data_1=%4h data_2=%4h rst_n=%b",sum, data_1, data_2, rst_n);
		return s;
	endfunction

	function string output2string();
		string s;
		s = $sformatf("sum=%4h", sum);
		return s;
	endfunction
	
endclass : trans1

