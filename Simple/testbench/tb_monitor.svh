class tb_monitor extends uvm_monitor;
	`uvm_component_utils(tb_monitor)

	virtual adder_interface adder_vi;

	uvm_analysis_port #(trans1) aport;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		aport = new("aport", this); // construct the analysis port
		// Get interface reference from config database
      if( !uvm_config_db #(virtual adder_interface)::get(this, "", "adder_interface", adder_vi) )
         `uvm_error("", "uvm_config_db::get failed")
	endfunction: build_phase

	task run_phase(uvm_phase phase); 
		forever begin 
			trans1 tx; 

			@(posedge adder_vi.clk); 
			tx = trans1::type_id::create("tx"); 
			tx.data_1 = adder_vi.data_1; 
			tx.data_2 = adder_vi.data_2; 
			tx.rst_n = adder_vi.rst_n; 
			tx.sum = adder_vi.sum; 

			aport.write(tx);
		end
	endtask: run_phase

endclass: tb_monitor