class tb_agent extends uvm_agent;
	`uvm_component_utils(tb_agent)

	tb_driver drv;
	tb_sequencer sqr;
	tb_monitor moni;

	uvm_analysis_port #(trans1) aport;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		aport = new("aport", this);
		drv = tb_driver::type_id::create("drv", this);
		sqr = tb_sequencer::type_id::create("sqr", this);
		moni = tb_monitor::type_id::create("moni", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		moni.aport.connect(aport);
	endfunction

endclass

// Without Monitor
/*class tb_agent extends uvm_agent;
	`uvm_component_utils(tb_agent)

	tb_driver drv;
	tb_sequencer sqr;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv = tb_driver::type_id::create("drv", this);
		sqr = tb_sequencer::type_id::create("sqr", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction

endclass*/