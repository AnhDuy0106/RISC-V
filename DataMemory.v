module DataMemory (
    input wire clk,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] wd,
    output wire [31:0] rd
);

  reg [31:0] RAM[63:0];

    always @(posedge clk) begin
        if (we)
            RAM[addr[31:2]] <= wd;
    end

    assign rd = RAM[addr[31:2]];

endmodule
