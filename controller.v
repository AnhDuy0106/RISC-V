module controller(
    input clock,
    input reset,
    input [6:0] op,
    input [2:0] funct3,
    input funct7b5,
    input ZeroE,
    input SignE,
    input FlushE,
    output ResultSrcE0,
    output [1:0] ResultSrcW,
    output memwriteM,
    output PCJalSrcE,
    output PCSrcE,
    output ALUSrcAE,
    output [1:0] ALUSrcBE,
    output RegWriteM,
    output RegWriteW,
    output [2:0] ImmSrcD,
    output [3:0] ALUcontrolE
);

wire [1:0] ALUOpD;
wire [1:0] ResultSrcD, ResultSrcE, ResultSrcM;
wire [3:0] ALUcontrolD;
wire BranchD, BranchE, memwriteD, memwriteE, JumpD, JumpE;
wire ZeroOp, ALUSrcAD, RegWriteD, RegWriteE;
wire [1:0] ALUSrcBD;
wire SignOp;
wire BranchOp;

maindec md(
    .op(op),
    .ResultSrc(ResultSrcD),
    .memwrite(memwriteD),
    .Branch(BranchD),
    .ALUSrcA(ALUSrcAD),
    .ALUSrcB(ALUSrcBD),
    .RegWrite(RegWriteD),
    .Jump(JumpD),
    .ImmSrc(ImmSrcD),
    .ALUOp(ALUOpD)
);

aludec ad(
    .opb5(op[5]),
    .funct3(funct3),
    .funct7b5(funct7b5),
    .ALUOp(ALUOpD),
    .ALUcontrol(ALUcontrolD)
);

c_ID_IEx c_pipreg0(
    .clock(clock),
    .reset(reset),
    .clear(FlushE),
    .RegWriteD(RegWriteD),
    .memwriteD(memwriteD),
    .JumpD(JumpD),
    .BranchD(BranchD),
    .ALUSrcAD(ALUSrcAD),
    .ALUSrcBD(ALUSrcBD),
    .ResultSrcD(ResultSrcD),
    .ALUcontrolD(ALUcontrolD),
    .RegWriteE(RegWriteE),
    .memwriteE(memwriteE),
    .JumpE(JumpE),
    .BranchE(BranchE),
    .ALUSrcAE(ALUSrcAE),
    .ALUSrcBE(ALUSrcBE),
    .ResultSrcE(ResultSrcE),
    .ALUcontrolE(ALUcontrolE)
);

assign ResultSrcE0 = ResultSrcE[0];

c_IEx_IM c_pipreg1(
    .clock(clock),
    .reset(reset),
    .RegWriteE(RegWriteE),
    .memwriteE(memwriteE),
    .ResultSrcE(ResultSrcE),
    .RegWriteM(RegWriteM),
    .memwriteM(memwriteM),
    .ResultSrcM(ResultSrcM)
);

c_IM_IW c_pipreg2(
    .clock(clock),
    .reset(reset),
    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW)
);

assign ZeroOp    = (ZeroE ^ funct3[0]);
assign SignOp    = (SignE ^ funct3[0]);
assign BranchOp  = funct3[2] ? SignOp : ZeroOp;
assign PCSrcE    = (BranchE & BranchOp) | JumpE;
assign PCJalSrcE = (op == 7'b1100111);

endmodule