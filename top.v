module top(
    input clock,
    input reset,
    output [31:0] writedataM,
    output [31:0] dataAdrM,
    output memwriteM
);

wire [31:0] PCF, InstrF, readDataM;

riscv_pip rv(
    .clock(clock),
    .reset(reset),
	.readDataM(readDataM),
    .InstrF(InstrF),
    .writedataM(writedataM),
    .ALUresultM(dataAdrM),
	.PCF(PCF),
    .memwriteM(memwriteM)
);

imem im(
    .a(PCF),
    .rd(InstrF)
);

dmem dm(
    .clock(clock),
    .we(memwriteM),
    .a(dataAdrM),
    .wd(writedataM),
    .rd(readDataM)
);

endmodule
