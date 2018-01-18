class trans1 extends uvm_sequence_item;

	logic signed [9:0] y;
	logic signed [9:0] cb;
	logic signed [9:0] cr;

	rand bit [9:0] r;
	rand bit [9:0] g;
	rand bit [9:0] b;

	`uvm_object_utils_begin(trans1)
	`uvm_field_int(y, UVM_ALL_ON)
	`uvm_field_int(cb, UVM_ALL_ON)
	`uvm_field_int(cr, UVM_ALL_ON)
	`uvm_field_int(r, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(g, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(b, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_object_utils_end

	constraint rgb_r { r >= 0; r < 256; }
	constraint rgb_g { g >= 0; g < 256; }
	constraint rgb_b { b >= 0; b < 256; }

	function new (string name="trans1");
		super.new(name);
	endfunction

	function string convert2string();
		string s;
		s = $sformatf("Y=%d Cb=%d Cr=%d R=%d G=%d B=%d",y, cb, cr, r, g, b);
		return s;
	endfunction

	function string output2string();
		string s;
		s = $sformatf("R=%d G=%d B=%d", r, g, b);
		return s;
	endfunction
	
endclass : trans1

