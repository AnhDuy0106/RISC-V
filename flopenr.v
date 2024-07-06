module flopenr (
    input clock,
    input reset,
    input en,
    input [31:0] d,
    output reg [31:0] q
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            q <= 32'b0;
        end else if (en) begin
            q <= d;
        end
    end

endmodule