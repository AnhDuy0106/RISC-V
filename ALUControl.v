module ALUControl (
    input wire [1:0] aluop,
    input wire [6:0] funct7,
    input wire [2:0] funct3,
    output reg [3:0] alucontrol
);

    always @(*) begin
        case (aluop)
            2'b00: alucontrol = 4'b0000; // add for load/store
            2'b01: alucontrol = 4'b0001; // subtract for branch
            2'b10: begin
                case ({funct7, funct3})
                    10'b0000000_000: alucontrol = 4'b0000; // add
                    10'b0100000_000: alucontrol = 4'b0001; // subtract
                    10'b0000000_111: alucontrol = 4'b0010; // and
                    10'b0000000_110: alucontrol = 4'b0011; // or
                    10'b0000000_100: alucontrol = 4'b0100; // xor
                    10'b0000000_001: alucontrol = 4'b0101; // sll
                    10'b0000000_101: alucontrol = 4'b0110; // srl
                    10'b0100000_101: alucontrol = 4'b0111; // sra
                    default: alucontrol = 4'b0000; // default to add
                endcase
            end
            default: alucontrol = 4'b0000;
        endcase
    end
endmodule

