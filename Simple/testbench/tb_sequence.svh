class tb_sequence extends uvm_sequence#(trans1);
	`uvm_object_utils(tb_sequence)

	trans1 tx;

	function new (string name = "");
     	super.new(name);
   endfunction

	task body();
		if (starting_phase != null)
        starting_phase.raise_objection(this);

		repeat(50) begin
			tx = trans1::type_id::create("tx");
			start_item(tx);
			assert(tx.randomize());
			finish_item(tx);
		end

		if (starting_phase != null)
        starting_phase.drop_objection(this);
	endtask
	
endclass:tb_sequence