module extend (
    input [24:0] instr,
    input [2:0] immsrc,
    output reg [31:0] immext
);

    always @(*) begin
        case(immsrc)
            3'b000: immext 	= {{20{instr[24]}}, instr[24:13]}; // I-type
            3'b001: immext 	= {{20{instr[24]}}, instr[24:18], instr[4:0]}; // S-type
            3'b010: immext 	= {{20{instr[24]}}, instr[24:18], instr[4:0]}; // B-type
            3'b011: immext 	= {instr[24:5], 12'b0}; // U-type
            3'b100: immext 	= {{11{instr[24]}}, instr[24], instr[12:5], instr[13], instr[23:14], 1'b0}; // J-type
            default: immext = 32'b0;
        endcase
    end

endmodule