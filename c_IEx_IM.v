module c_IEx_IM (
    input clock,
    input reset,
    input [1:0] ResultSrcE,
    input RegWriteE,
    input memwriteE,
    output reg  RegWriteM,
    output reg memwriteM,
    output reg [1:0] ResultSrcM
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            RegWriteM  <= 0; 
            memwriteM  <= 0; 
            ResultSrcM <= 0; 
        end else begin
            RegWriteM  <= RegWriteE;
            memwriteM  <= memwriteE;
            ResultSrcM <= ResultSrcE;
        end
    end

endmodule