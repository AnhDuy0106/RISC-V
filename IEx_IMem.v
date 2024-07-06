module IEx_IMem(
	input clock, reset,
	input [31:0] ALUresultE, writedataE,
	input [4:0] RdE,
	input [31:0] PCPlus4E,
	output reg [31:0] ALUresultM, writedataM,
	output reg [4:0] RdM,
	output reg [31:0] PCPlus4M
);
always @( posedge clock, posedge reset) begin
	if(reset) begin
		ALUresultM <= 0;
		writedataM <= 0;
		RdM 	   <= 0;
		PCPlus4M   <= 0;
	 end
	else begin
		ALUresultM <= ALUresultE;
		writedataM <= writedataE;
		RdM 	   <= RdE;
		PCPlus4M   <= PCPlus4E;
	  end
	end
endmodule	