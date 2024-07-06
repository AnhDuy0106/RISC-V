module riscv_pip(
    input clock,
    input reset,
    input  [31:0] readDataM,
    input  [31:0] InstrF,
    output [31:0] writedataM,
    output [31:0] ALUresultM,
    output [31:0] PCF,
    output memwriteM
);

wire ALUSrcAE, RegwriteM, RegwriteW, ZeroE, SignE, PCJalSrcE, PCSrcE;
wire [1:0] ALUSrcBE;
wire StallD, StallF, FlushD, FlushE, ResultSrcE0;
wire [1:0] ResultSrcW;
wire [2:0] ImmSrcD;
wire [3:0] ALUcontrolE;
wire [31:0] InstrD;
wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E;
wire [4:0] RdE, RdM, RdW;
wire [1:0] ForwardAE, ForwardBE;

controller c(
    .clock(clock),
    .reset(reset),
    .op(InstrD[6:0]),
    .funct3(InstrD[14:12]),
    .funct7b5(InstrD[30]),
    .ZeroE(ZeroE),
    .SignE(SignE),
    .FlushE(FlushE),
    .ResultSrcE0(ResultSrcE0),
    .ResultSrcW(ResultSrcW),
    .memwriteM(memwriteM),
    .PCJalSrcE(PCJalSrcE),
    .PCSrcE(PCSrcE),
    .ALUSrcAE(ALUSrcAE),
    .ALUSrcBE(ALUSrcBE),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegwriteW),
    .ImmSrcD(ImmSrcD),
    .ALUcontrolE(ALUcontrolE)
);

hazardunit h(
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RdE(RdE),
    .RdM(RdM),
    .RdW(RdW),
    .RegWriteW(RegWriteW),
    .RegWriteM(RegWriteM),
    .ResultSrcE0(ResultSrcE0),
    .PCSrcE(PCSrcE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .StallD(StallD),
    .StallF(StallF),
    .FlushD(FlushD),
    .FlushE(FlushE)
);

datapath_unit d(
    .clock(clock),
    .reset(reset),
    .ResultSrcW(ResultSrcW),
    .PCJalSrcE(PCJalSrcE),
    .PCSrcE(PCSrcE),
    .ALUSrcAE(ALUSrcAE),
    .ALUSrcBE(ALUSrcBE),
    .RegwriteW(RegwriteW),
    .ImmSrcD(ImmSrcD),
    .ALUcontrolE(ALUcontrolE),
    .ZeroE(ZeroE),
    .SignE(SignE),
    .PCF(PCF),
    .InstrF(InstrF),
    .InstrD(InstrD),
    .ALUresultM(ALUresultM),
    .writedataM(writedataM),
    .readDataM(readDataM),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RdE(RdE),
    .RdM(RdM),
    .RdW(RdW),
    .StallD(StallD),
    .StallF(StallF),
    .FlushD(FlushD),
    .FlushE(FlushE)
);

endmodule
