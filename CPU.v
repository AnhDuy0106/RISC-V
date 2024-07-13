module CPU (
    input wire clk,
    input wire reset
);

    wire [31:0] pc;
    wire [31:0] instr;
    wire [31:0] rd1;
    wire [31:0] rd2;
    wire [31:0] imm;
    wire [31:0] alu_result;
    wire [31:0] mem_rd;
    wire [31:0] wd;
    wire zero;
    wire branch;
    wire memwrite;
    wire regwrite;
    wire alusrc;
    wire memtoreg;
    wire [1:0] aluop;
    wire [3:0] alucontrol;

    // Instantiate components
    ProgramCounter PC (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    InstructionMemory IM (
        .a(pc),
        .rd(instr)
    );

    RegisterFile RF (
        .clk(clk),
        .we(regwrite),
        .rs1(instr[19:15]),
        .rs2(instr[24:20]),
        .rd(instr[11:7]),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    ALUControl ALUC (
        .aluop(aluop),
        .funct7(instr[31:25]),
        .funct3(instr[14:12]),
        .alucontrol(alucontrol)
    );

    ALU ALU (
        .A(rd1),
        .B(alusrc ? imm : rd2),
        .ALUControl(alucontrol),
        .Result(alu_result),
        .Zero(zero)
    );

    DataMemory DM (
        .clk(clk),
        .we(memwrite),
        .addr(alu_result),
        .wd(rd2),
        .rd(mem_rd)
    );

    ControlUnit CU (
        .opcode(instr[6:0]),
        .ALUOp(aluop),
        .MemWrite(memwrite),
        .RegWrite(regwrite),
        .ALUSrc(alusrc),
        .MemToReg(memtoreg),
        .Branch(branch)
    );

    // Sign extend immediate
    assign imm = {{20{instr[31]}}, instr[31:20]};

    // Write data to register file
    assign wd = memtoreg ? mem_rd : alu_result;

endmodule
