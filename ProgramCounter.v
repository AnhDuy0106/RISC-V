module ProgramCounter (
    input wire clk,
    input wire reset,
    output reg [31:0] pc
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc + 4;
    end

endmodule
