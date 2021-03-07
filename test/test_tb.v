// vim: ts=2 sw=2 sts=2 sr noet
`timescale 1 ns/10 ps

`default_nettype none

module test_testbench;

reg test_in;
wire test_out;

initial begin
	$dumpfile("test.vcd");
	$dumpvars(0, test_testbench);
end

top uut(
	.P1A2(test_in),
	.P1A1(test_out)
);

initial begin
	test_in <= 1'b1;
	# 100;
	`assert(test_out, 1'b0);
	test_in <= 1'b0;
	# 100;
	`assert(test_out, 1'b1);
end

endmodule
