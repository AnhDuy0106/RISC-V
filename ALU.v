module ALU (
    input wire [31:0] A, 
    input wire [31:0] B, 
    input wire [3:0] ALUControl, 
    output reg [31:0] Result, 
    output reg Zero
);

    always @(*) begin
        case (ALUControl)
            4'b0000: Result = A + B;  // ADD
            4'b0001: Result = A - B;  // SUB
            4'b0010: Result = A & B;  // AND
            4'b0011: Result = A | B;  // OR
            4'b0100: Result = A ^ B;  // XOR
            4'b0101: Result = A << B; // SLL
            4'b0110: Result = A >> B; // SRL
            4'b0111: Result = $signed(A) >>> B; // SRA
            default: Result = 0;
        endcase
        Zero = (Result == 0);
    end

endmodule
