class tb_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(tb_scoreboard)

	uvm_analysis_export #(trans1) axp_in;
	uvm_analysis_export #(trans1) axp_out;
	sb_int_predictor prd_int;
	sb_flaot_predictor prd_flaot;
	sb_comparator cmp;

	function new(string name, uvm_component parent); 
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		axp_in = new("axp_in", this);
		axp_out = new("axp_out", this);
		prd_int = sb_int_predictor::type_id::create("prd_int", this);
		prd_flaot = sb_flaot_predictor::type_id::create("prd_flaot", this);
		cmp = sb_comparator::type_id::create("cmp", this);
	endfunction

	function void connect_phase( uvm_phase phase );
		axp_in.connect (prd_int.analysis_export);
		axp_out.connect (prd_flaot.analysis_export);

		prd_int.results_ap.connect (cmp.axp_in);
		prd_flaot.results_ap.connect(cmp.axp_out);
	endfunction

endclass