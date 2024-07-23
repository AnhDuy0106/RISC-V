module CPU (
    input wire clk,
    input wire reset
   
);
  // Wires and Registers
  	wire [31:0] pc;
  	wire [3:0] alucontrol;
    wire [31:0] instr;           // Instruction read from InstructionMemory
    wire [31:0] rd1, rd2;        // RegisterFile read data
    wire [31:0] alu_result;      // Result from ALU
    wire [31:0] data_mem_out;    // Data read from DataMemory
    wire [31:0] alu_operand2;    // Second operand for ALU
    wire [1:0] alu_op;           // ALU operation select
    wire mem_write;              // Memory write enable
    wire reg_write;              // Register write enable
    wire alu_src;                // ALU source select
    wire mem_to_reg;             // Memory to register data select
    wire branch;                 // Branch control signal

    
    ProgramCounter pc_inst (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    InstructionMemory instr_mem (
        .a(pc),
        .rd(instr)
    );


    wire [6:0] opcode = instr[6:0];
    wire [6:0] funct7 = instr[31:25];
    wire [2:0] funct3 = instr[14:12];
    wire [4:0] rs1 = instr[19:15];
    wire [4:0] rs2 = instr[24:20];
    wire [4:0] rd = instr[11:7];
    
    ControlUnit control (
        .opcode(opcode),
        .ALUOp(alu_op),
        .MemWrite(mem_write),
        .RegWrite(reg_write),
        .ALUSrc(alu_src),
        .MemToReg(mem_to_reg),
        .Branch(branch)
    );

    ALUControl alu_control (
        .aluop(alu_op),
        .funct7(funct7),
        .funct3(funct3),
        .alucontrol(alucontrol)
    );

    RegisterFile reg_file (
        .clk(clk),
        .we(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(alu_result),
        .rd1(rd1),
        .rd2(rd2)
    );

    DataMemory data_mem (
        .clk(clk),
        .we(mem_write),
        .addr(alu_result),
        .wd(rd2),
        .rd(data_mem_out)
    );

    ALU alu (
        .A(rd1),
        .B(alu_operand2),
        .ALUControl(alucontrol),
        .Result(alu_result),
        .Zero()
    );

    
    assign alu_operand2 = alu_src ? rd2 : instr[31:0];  // Immediate value or register value (B)

endmodule
