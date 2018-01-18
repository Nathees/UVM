class sb_flaot_predictor extends uvm_subscriber #(trans1);

	`uvm_component_utils(sb_flaot_predictor)

	uvm_analysis_port #(trans1) results_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		results_ap = new("results_ap", this);
	endfunction

	function void write(trans1 t);
		trans1 exp_tr;
		//---------------------------
		exp_tr = sb_calc_exp(t);
		results_ap.write(exp_tr);
	endfunction

	extern function trans1 sb_calc_exp(trans1 t);

endclass

function trans1 sb_flaot_predictor::sb_calc_exp (trans1 t);

	shortreal y_float;
	shortreal cb_float;
	shortreal cr_float;

	int y_int, cb_int, cr_int;

	trans1 tr = trans1::type_id::create("tr");

	//---------------------------
	`uvm_info(get_type_name(), t.convert2string(), UVM_HIGH)
	// async reset: reset the next_sum AND current sum values -OR-
	// non-reset : assign sum values & calculate the next_sum values
	y_float = 0.299*t.r + 0.587*t.g + 0.114*t.b - 128; // - 128
	if (y_float >127)
		y_float = 127;
	else if (y_float < -128)
		y_float = -128;

	cb_float = -0.168736*t.r - 0.331264*t.g + 0.5*t.b;
	if (cb_float >127)
		cb_float = 127;
	else if (cb_float < -128)
		cb_float = -128;

	cr_float = 0.5*t.r - 0.418688*t.g - 0.081312*t.b;
	if (cr_float >127)
		cr_float = 127;
	else if (cr_float < -128)
		cr_float = -128;
	// copy all sampled inputs & outputs
	tr.copy(t);
	
	y_int = y_float;
	cb_int = cb_float;
	cr_int = cr_float;

	tr.y = int'(y_int);
	tr.cb = int'(cb_int);
	tr.cr = int'(cr_int);
	return(tr);
endfunction

