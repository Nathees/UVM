`timescale 1ns / 1ps

interface dut_interface;

	// DUT System Clock Signals
	logic 														clk;

	// Data Control Signals
	logic					[9:0] 								r;
	logic					[9:0] 								g;
	logic					[9:0]								b;

	initial begin
		clk = 0;
		forever begin
			#1
			clk = ~clk;
		end
	end
	
endinterface