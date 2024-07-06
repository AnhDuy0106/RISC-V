module datapath_unit(
    input clock, reset,
    input [1:0] ResultSrcW,
    input PCJalSrcE, PCSrcE, ALUSrcAE,
    input [1:0] ALUSrcBE,
    input RegwriteW,
    input [2:0] ImmSrcD,
    input [3:0] ALUcontrolE,
    output ZeroE,
    output SignE,
    output [31:0] PCF,
    input [31:0] InstrF,
    output [31:0] InstrD,
    output [31:0] ALUresultM, writedataM,
    input [31:0] readDataM,
    input [1:0] ForwardAE, ForwardBE,
    output [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
    output [4:0] RdE, RdM, RdW,
    input StallD, StallF, FlushD, FlushE
);

wire [31:0] PCD, PCE, ALUresultE, ALUresultW, readDataW;
wire [31:0] PCNextF, PCPlus4F, PCPlus4D, PCPlus4E, PCPlus4M, PCPlus4W, PCTargetE, BranJumpTargetE;
wire [31:0] writedataE;
wire [31:0] ImmExtD, ImmExtE;
wire [31:0] SrcAEfor, SrcAE, SrcBE, RD1D, RD2D, RD1E, RD2E;
wire [31:0] ResultW;
wire [4:0] RdD;

mux2 jal_r(
    .a(PCTargetE),	//00
    .b(ALUresultE),	//01
    .sel(PCJalSrcE),
    .y(BranJumpTargetE)
);

mux2 pcmux(
    .a(PCPlus4F),		 //00
    .b(BranJumpTargetE), //01
    .sel(PCSrcE),
    .y(PCNextF)
);

flopenr IF(
    .clock(clock),
    .reset(reset),
    .en(~StallF),
    .d(PCNextF),
    .q(PCF)
);

adder pcadd4(
    .a(PCF),
    .b(32'd4),
    .y(PCPlus4F)
);

IF_ID pipreg0(
    .clock(clock),
    .reset(reset),
    .clear(FlushD),
    .enable(~StallD),
    .InstrF(InstrF),
    .PCF(PCF),
    .PCPlus4F(PCPlus4F),
    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
);

assign Rs1D = InstrD[19:15];
assign Rs2D = InstrD[24:20];

regfile rf(
    .clock(clock),
    .we3(RegwriteW),
    .a1(Rs1D),
    .a2(Rs2D),
    .a3(RdW),
    .wd3(ResultW),
    .rd1(RD1D),
    .rd2(RD2D)
);

assign RdD = InstrD[11:7];

extend ext(
    .instr(InstrD[31:7]),
    .immsrc(ImmSrcD),
    .immext(ImmExtD)
);

ID_IEx pipreg1(
    .clock(clock),
    .reset(reset),
    .clear(FlushE),
    .RD1D(RD1D),
    .RD2D(RD2D),
    .PCD(PCD),
    .RdD(RdD),
    .ImmExtD(ImmExtD),
    .PCPlus4D(PCPlus4D),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .PCE(PCE),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RdE(RdE),
    .ImmExtE(ImmExtE),
    .PCPlus4E(PCPlus4E)
);

mux3 forwardMuxA(
    .a(RD1E), 		//00
    .b(ResultW), 	//01
    .c(ALUresultM), //10
    .sel(ForwardAE), 
    .y(SrcAEfor)
);

mux2 scrcamux(
    .a(SrcAEfor), 	//00
    .b(32'b0), 		//01
    .sel(ALUSrcAE),
    .y(SrcAE)
);

mux3 forwardMuxB(
    .a(RD2E), 		//00
    .b(ResultW), 	//01
    .c(ALUresultM), //10
    .sel(ForwardBE),
    .y(writedataE)
);

mux3 srcbmux(
    .a(writedataE), //00
    .b(ImmExtE),	//01
    .c(PCTargetE),	//10
    .sel(ALUSrcBE),
    .y(SrcBE)
);

adder pcaddbranch(
    .a(PCE),
    .b(ImmExtE),
    .y(PCTargetE)
);

alu alu( 
    .SrcA(SrcAE),
    .SrcB(SrcBE),
    .ALUcontrol(ALUcontrolE),
    .ALUresult(ALUresultE),
    .Zero(ZeroE),
    .Sign(SignE)
);

IEx_IMem pipreg2(
    .clock(clock),
    .reset(reset),
    .ALUresultE(ALUresultE),
    .writedataE(writedataE),
    .RdE(RdE),
    .PCPlus4E(PCPlus4E),
    .ALUresultM(ALUresultM),
    .writedataM(writedataM),
    .RdM(RdM),
    .PCPlus4M(PCPlus4M)
);

IMem_IW pipreg3(
    .clock(clock),
    .reset(reset),
    .ALUresultM(ALUresultM),
    .readDataM(readDataM),
    .RdM(RdM),
    .PCPlus4M(PCPlus4M),
    .ALUresultW(ALUresultW),
    .readDataW(readDataW),
    .RdW(RdW),
    .PCPlus4W(PCPlus4W)
);

mux3 resultmux(
    .a(ALUresultW), //00
    .b(readDataW),	//01
    .c(PCPlus4W),	//10
    .sel(ResultSrcW),
    .y(ResultW)
);

endmodule