class sb_comparator extends uvm_component;
	`uvm_component_utils(sb_comparator)

	uvm_analysis_export #(trans1) axp_in;
	uvm_analysis_export #(trans1) axp_out;
	uvm_tlm_analysis_fifo #(trans1) expfifo;
	uvm_tlm_analysis_fifo #(trans1) outfifo;

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		axp_in = new("axp_in", this);
		axp_out = new("axp_out", this);
		expfifo = new("expfifo", this);
		outfifo = new("outfifo", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		axp_in.connect (expfifo.analysis_export);
		axp_out.connect(outfifo.analysis_export);
	endfunction

	task run_phase(uvm_phase phase);
		trans1 exp_tr, out_tr;

		forever begin
			`uvm_info("sb_comparator run task","WAITING for expected output", UVM_DEBUG)
			expfifo.get(exp_tr);
			`uvm_info("sb_comparator run task","WAITING for actual output", UVM_DEBUG)
			outfifo.get(out_tr);

			`uvm_info ("Interger Operation ", $sformatf("%s \n",exp_tr.convert2string()), UVM_HIGH)
			`uvm_info ("Float Operation ", $sformatf("%s \n",out_tr.convert2string()), UVM_HIGH)
			
			if(exp_tr.y ==  out_tr.y)	
				PASS();
			else if((exp_tr.y - out_tr.y == 1) || (exp_tr.y - out_tr.y == -1))
				ERROR_1();
			else
				ERROR();


			if(exp_tr.cb ==  out_tr.cb)	
				PASS();
			else if((exp_tr.cb - out_tr.cb == 1) || (exp_tr.cb - out_tr.cb == -1))
				ERROR_1();
			else
				ERROR();

			if(exp_tr.cr ==  out_tr.cr)	
				PASS();
			else if((exp_tr.cr - out_tr.cr == 1) || (exp_tr.cr - out_tr.cr == -1))
				ERROR_1();
			else
				ERROR();
		end
	endtask

	int VECT_CNT, PASS_CNT, ERROR_1_CNT, ERROR_2_CNT;

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(),$sformatf("\n\n\n*** TEST Report - [%0d vectors ran], [%0d vectors passed], [%0d vectors =1 failed], [%0d vectors >1 failed] ***\n",
			VECT_CNT, PASS_CNT, ERROR_1_CNT, ERROR_2_CNT), UVM_LOW)
	endfunction

	function void PASS();
		VECT_CNT++;
		PASS_CNT++;
	endfunction

	function void ERROR_1();
		VECT_CNT++;
		ERROR_1_CNT++;
	endfunction

	function void ERROR();
		VECT_CNT++;
		ERROR_2_CNT++;
	endfunction
	
endclass