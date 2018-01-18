class tb_monitor extends uvm_monitor;
	`uvm_component_utils(tb_monitor)

	virtual dut_interface dut_vi;

	uvm_analysis_port #(trans1) aport;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		aport = new("aport", this); // construct the analysis port
		// Get interface reference from config database
      if( !uvm_config_db #(virtual dut_interface)::get(this, "", "dut_interface", dut_vi) )
         `uvm_error("", "uvm_config_db::get failed")
	endfunction: build_phase

	task run_phase(uvm_phase phase); 
		forever begin 
			trans1 tx; 

			@(posedge dut_vi.clk); 
			tx = trans1::type_id::create("tx"); 
			tx.r = dut_vi.r; 
			tx.g = dut_vi.g; 
			tx.b = dut_vi.b; 

			aport.write(tx);
		end
	endtask: run_phase

endclass: tb_monitor