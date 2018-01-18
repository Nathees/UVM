class tb_env extends uvm_env;
	`uvm_component_utils(tb_env)

	tb_agent agnt;
	tb_scoreboard sc_bord;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = tb_agent::type_id::create("agnt", this);
		sc_bord = tb_scoreboard::type_id::create("sc_bord", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agnt.aport.connect(sc_bord.axp_in);
		agnt.aport.connect(sc_bord.axp_out);
	endfunction: connect_phase

endclass : tb_env



// Without Score Board
/*class tb_env extends uvm_env;
	`uvm_component_utils(tb_env)

	tb_agent agnt;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = tb_agent::type_id::create("agnt", this);
	endfunction

endclass : tb_env*/