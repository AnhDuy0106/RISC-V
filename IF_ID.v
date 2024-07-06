module IF_ID (
	input clock, reset, clear, enable,
	input [31:0] InstrF, PCF, PCPlus4F,
	output reg [31:0] InstrD, PCD, PCPlus4D
);
always @( posedge clock, posedge reset) begin
	if(reset) begin
		InstrD   <= 0;
		PCD 	 <= 0;
		PCPlus4D <= 0;
		end
	else if	(enable) begin
		if(clear) begin
			InstrD 	 <= 0;
			PCD 	 <= 0;
			PCPlus4D <= 0;
		end
		else begin 
		InstrD   <= InstrF;
		PCD 	 <= PCF;
		PCPlus4D <= PCPlus4F;
		end
	end
end

endmodule		