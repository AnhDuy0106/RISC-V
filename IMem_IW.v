module IMem_IW (
    input clock,
    input reset,
    input [31:0] ALUresultM,
    input [31:0] readDataM,
    input [4:0] RdM,
    input [31:0] PCPlus4M,
    output reg [31:0] ALUresultW,
    output reg [31:0] readDataW,
    output reg [4:0] RdW,
    output reg [31:0] PCPlus4W
);

always @(posedge clock or posedge reset) begin
    if (reset) begin
        ALUresultW <= 0;
        readDataW  <= 0;
        RdW 	   <= 0;
        PCPlus4W   <= 0;
    end else begin
        ALUresultW <= ALUresultM;
        readDataW  <= readDataM;
        RdW        <= RdM;
        PCPlus4W   <= PCPlus4M;
    end
end

endmodule