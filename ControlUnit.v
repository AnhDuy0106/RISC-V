module ControlUnit (
    input wire [6:0] opcode,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg RegWrite,
    output reg ALUSrc,
    output reg MemToReg,
    output reg Branch
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                ALUOp = 2'b10;
                MemWrite = 0;
                RegWrite = 1;
                ALUSrc = 0;
                MemToReg = 0;
                Branch = 0;
            end
            7'b0000011: begin // Load
                ALUOp = 2'b00;
                MemWrite = 0;
                RegWrite = 1;
                ALUSrc = 1;
                MemToReg = 1;
                Branch = 0;
            end
            7'b0100011: begin // Store
                ALUOp = 2'b00;
                MemWrite = 1;
                RegWrite = 0;
                ALUSrc = 1;
                MemToReg = 0;
                Branch = 0;
            end
            7'b1100011: begin // Branch
                ALUOp = 2'b01;
                MemWrite = 0;
                RegWrite = 0;
                ALUSrc = 0;
                MemToReg = 0;
                Branch = 1;
            end
            default: begin
                ALUOp = 2'b00;
                MemWrite = 0;
                RegWrite = 0;
                ALUSrc = 0;
                MemToReg = 0;
                Branch = 0;
            end
        endcase
    end

endmodule
