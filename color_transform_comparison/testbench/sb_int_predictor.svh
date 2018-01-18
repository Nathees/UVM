class sb_int_predictor extends uvm_subscriber #(trans1);

	`uvm_component_utils(sb_int_predictor)

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

function trans1 sb_int_predictor::sb_calc_exp (trans1 t);

	static logic [16:0] next_sum1;
	logic signed [9:0] y;
	logic signed [9:0] cb;
	logic signed [9:0] cr;

	trans1 tr = trans1::type_id::create("tr");

	//---------------------------
	`uvm_info(get_type_name(), t.convert2string(), UVM_HIGH)
	// async reset: reset the next_sum AND current sum values -OR-
	// non-reset : assign sum values & calculate the next_sum values
	y = ((((9798*t.r >> 14) + 1) + ((19235*t.g >> 14) + 1) + ((3736*t.b >> 14) + 1)) >> 1) - 128;
	if (y > 127)
		y = 127;
	else if (y < -128)
		y = -128;

	cb = (((-5529*t.r >> 14) + 1) + ((-10855*t.g >> 14) + 1) + (t.b + 1)) >> 1;
	if (cb > 127)
		cb = 127;
	else if (cb < -128)
		cb = -128;

	cr = ((t.r + 1) + ((-13720*t.g >> 14) + 1) + ((-2664*t.b >> 14) + 1)) >> 1;
	if (cr > 127)
		cr = 127;
	else if (cr < -128)
		cr = -128;
	// copy all sampled inputs & outputs
	tr.copy(t);

	tr.y = y;
	tr.cb = cb;
	tr.cr = cr;
	return(tr);
endfunction

