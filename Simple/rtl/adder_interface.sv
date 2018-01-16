`timescale 1ns / 1ps

interface adder_interface;

	// DUT System Clock Signals
	logic 														clk;
  	logic 														rst_n;

	// Data Control Signals
	logic					[15:0] 								data_1;
	logic					[15:0] 								data_2;
	logic					[16:0]								sum;

	initial begin
		clk = 0;
		forever begin
			#5
			clk = ~clk;
		end
	end
	
endinterface