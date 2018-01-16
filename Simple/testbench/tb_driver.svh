class tb_driver extends uvm_driver #(trans1);
  
   `uvm_component_utils(tb_driver)

   virtual adder_interface adder_vi;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction
    
   function void build_phase(uvm_phase phase);
      // Get interface reference from config database
      if( !uvm_config_db #(virtual adder_interface)::get(this, "", "adder_interface", adder_vi) )
         `uvm_error("", "uvm_config_db::get failed")
   endfunction 
   
   task run_phase(uvm_phase phase);
      trans1 tx;
      forever begin
         seq_item_port.get_next_item(tx);
         `uvm_info("tb_driver", tx.convert2string(), UVM_MEDIUM)
         
         // Wiggle pins of DUT
         @(posedge adder_vi.clk);
         adder_vi.data_1  = tx.data_1;
         adder_vi.data_2 = tx.data_2;
         adder_vi.rst_n = tx.rst_n;
         seq_item_port.item_done();
      end
   endtask

endclass: tb_driver
