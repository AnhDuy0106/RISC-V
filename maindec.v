module maindec(
    input [6:0] op,
    output wire [1:0] ResultSrc,
    output wire memwrite,
    output wire Branch, ALUSrcA,
    output wire [1:0] ALUSrcB,
    output wire RegWrite, Jump,
    output wire [2:0] ImmSrc,
    output wire [1:0] ALUOp
);

reg [13:0] controls;
assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, memwrite, ResultSrc, Branch, ALUOp, Jump} = controls;

always @(*) begin
    case(op)
        7'b0000011: controls = 14'b1_000_0_01_0_01_0_00_0; // Load
        7'b0100011: controls = 14'b0_001_0_01_1_00_0_00_0; // Store
        7'b0110011: controls = 14'b1_xxx_0_00_0_00_0_10_0; // R-type
        7'b1100011: controls = 14'b0_010_0_00_0_00_1_01_0; // Branch
        7'b0010011: controls = 14'b1_000_0_01_0_00_0_10_0; // I-type
        7'b1101111: controls = 14'b1_011_0_00_0_10_0_00_1; // Jump
        7'b0000000: controls = 14'b0_000_0_00_0_00_0_00_0; // NOP (No Operation)
        default:    controls = 14'bx_xxx_x_xx_x_xx_x_xx_x; // Undefined
    endcase
end

endmodule