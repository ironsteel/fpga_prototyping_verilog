// vim: ts=2 sw=2 sts=2 sr noet

`default_nettype none

module top(
	input  wire  CLK,
	input  wire  P1A2,
	output wire  P1A1
);

	assign P1A1 = ~P1A2;

endmodule
