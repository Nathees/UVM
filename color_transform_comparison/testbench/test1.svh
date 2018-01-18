class test1 extends uvm_test;
	`uvm_component_utils(test1)

	tb_env env;

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = tb_env::type_id::create("env", this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		this.print();
		factory.print();
	endfunction

	task run_phase(uvm_phase phase);
		tb_sequence seq;
		phase.raise_objection(this);
		seq = tb_sequence::type_id::create("seq");
		//optionally randomize sequence
		//assert(seq.randomize());
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);
	endtask

endclass : test1