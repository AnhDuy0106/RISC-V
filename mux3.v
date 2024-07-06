module mux3 (
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [1:0] sel,
    output [31:0] y
);
    assign y = (sel == 2'b00) ? a :(sel == 2'b01) ? b :c;
endmodule