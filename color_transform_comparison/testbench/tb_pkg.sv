package tb_pkg;
   import uvm_pkg::*;

   virtual interface dut_interface dut_vi;

   // UVM Macros
   `include "uvm_macros.svh"

   // uvm_transactions
   `include "trans1.svh"
   `include "tb_sequence.svh"

   // uvm_agents 
   `include "tb_driver.svh"
   `include "tb_sequencer.svh"
   `include "tb_monitor.svh"
   `include "tb_agent.svh"

   // uvm_scoreboards
   `include "sb_int_predictor.svh"
   `include "sb_flaot_predictor.svh"
   `include "sb_comparator.svh"
   `include "tb_scoreboard.svh"

   // uvm_envs  
   `include "tb_env.svh"

   // uvm_tests  
   `include "test1.svh"

endpackage