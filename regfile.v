module regfile(
	input clock,
	input we3,
	input [4:0] a1, a2, a3,
	input [31:0] wd3,
	output [31:0] rd1, rd2
);

reg [31:0] rf[31:0];

assign rd1 = (a1 != 0) ? rf[a1] :0;
assign rd2 = (a1 != 0) ? rf[a2] :0;
always @(negedge clock) begin
	if (we3) begin
	rf[a3] <= wd3;
	end
  end
endmodule	