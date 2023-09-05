`timescale 1ns / 1ps
module pes_ripco_tb;
	// Inputs
	reg clk, reset   ;
	// Output
	wire [1:0] q;

        // Instantiate the Unit Under Test (UUT)
	pes_ripco uut (
		.clk(clk),
		.reset(reset),
		.q(q)
	);

	initial begin
	$dumpfile("pes_ripco_tb.vcd");
	$dumpvars(0,pes_ripco_tb);
	// Initialize Inputs
	clk = 0;
	reset = 1;
	#3000 $finish;
	end

always #10 clk = ~clk;
always #1547 reset=~reset;
endmodule
