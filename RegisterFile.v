module RegisterFile (
    input wire clk,
    input wire we,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] wd,
    output wire [31:0] rd1,
    output wire [31:0] rd2
);

    reg [31:0] rf[31:0];

    always @(posedge clk) begin
        if (we)
            rf[rd] <= wd;
    end

    assign rd1 = (rs1 != 0) ? rf[rs1] : 0;
    assign rd2 = (rs2 != 0) ? rf[rs2] : 0;

endmodule
