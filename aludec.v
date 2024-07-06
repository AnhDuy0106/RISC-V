module aludec(
    input opb5,
    input [2:0] funct3,
    input funct7b5,
    input [1:0] ALUOp,
    output reg [3:0] ALUcontrol
);
    wire RtypeSub;
    assign RtypeSub = funct7b5 & opb5;

    always @(*) begin
        case(ALUOp)
            2'b00: ALUcontrol = 4'b0000; // ADD
            2'b01: ALUcontrol = 4'b0001; // SUB
            default: case(funct3)
                3'b000: ALUcontrol 	= RtypeSub ? 4'b0001 : 4'b0000; // SUB : ADD
                3'b001: ALUcontrol	= 4'b0100; // SLL
                3'b010: ALUcontrol 	= 4'b0101; // SLT
                3'b011: ALUcontrol 	= 4'b1000; // SLTU
                3'b100: ALUcontrol 	= 4'b0110; // XOR
                3'b101: ALUcontrol 	= funct7b5 ? 4'b1111 : 4'b0111; // SRA : SRL
                3'b110: ALUcontrol 	= 4'b0011; // OR
                3'b111: ALUcontrol 	= 4'b0010; // AND
                default: ALUcontrol = 4'bxxxx; // Undefined
            endcase
        endcase
    end
endmodule