module alu(
	input [31:0] SrcA,
	input [31:0] SrcB,
	input [3:0] ALUcontrol,
	output reg [31:0] ALUresult,
	output wire Zero, Sign
);
wire [31:0] Sum;
wire Overflow;
assign  Sum = SrcA + (ALUcontrol[0] ? ~ SrcB : SrcB) + ALUcontrol[0];
assign Overflow = ~(ALUcontrol[0] ^ SrcB[31] ^ SrcA[31]) & (SrcA[31] ^ Sum[31]) & (~ALUcontrol[1]);
assign Zero = ~(|ALUresult);
assign Sign = ALUresult[31];

always @(*) begin
	case (ALUcontrol)
		4'b000x: ALUresult = Sum;
		4'b0010: ALUresult = SrcA & SrcB; //and
		4'b0011: ALUresult = SrcA | SrcB; //or
		4'b0100: ALUresult = SrcA << SrcB; // sll, slli
		4'b0101: ALUresult = {{30{1'b0}}, Overflow ^ Sum[31]}; // slt, slti
		4'b0110: ALUresult = SrcA ^ SrcB; //xor
		4'b0111: ALUresult = SrcA >> SrcB; //shift logic
		4'b1000: ALUresult = ($unsigned(SrcA) < $unsigned(SrcB)); // sltu, stlui
		4'b1111: ALUresult = SrcA >>> SrcB; //shift arithmetic
		default: ALUresult = 32'bx;
		
	endcase
  end
endmodule  