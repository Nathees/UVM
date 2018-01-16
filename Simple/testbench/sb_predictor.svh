class sb_predictor extends uvm_subscriber #(trans1);

	`uvm_component_utils(sb_predictor)

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

function trans1 sb_predictor::sb_calc_exp (trans1 t);

	static logic [16:0] next_sum1, next_sum2;
	logic [16:0] sum;

	trans1 tr = trans1::type_id::create("tr");

	//---------------------------
	`uvm_info(get_type_name(), t.convert2string(), UVM_HIGH)
	// async reset: reset the next_sum AND current sum values -OR-
	// non-reset : assign sum values & calculate the next_sum values
	
	sum = next_sum2;
	next_sum2 = next_sum1;
	next_sum1 = t.data_1 + t.data_2;
	// copy all sampled inputs & outputs
	tr.copy(t);
	// overwrite the sum values with the calculated values.
	// sum values were either calculated in the previous cycle
	// or asynchronously reset in this cycle
	tr.sum = sum;
	return(tr);
endfunction