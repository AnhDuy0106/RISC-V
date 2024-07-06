`timescale 1ns/1ns
`include "top.v"
`include "riscv_pip.v"
`include "datapath_unit.v"
`include "hazardunit.v"
`include "controller.v"
`include "maindec.v"
`include "aludec.v"
`include "alu.v"
`include "imem.v"
`include "regfile.v"
`include "IEx_IMem.v"
`include "IF_ID.v"
`include "IMem_IW.v"
`include "dmem.v"
`include "ID_IEx.v"
`include "mux2.v"
`include "mux3.v"
`include "extend.v"
`include "flopenr.v"
`include "adder.v"
`include "c_ID_IEx.v"
`include "c_IM_IW.v"
`include "c_IEx_IM.v"
module testbench();
    reg clock = 0;
    reg reset;
    
    wire [31:0] writedata, dataAdr;
    wire memwrite;
    
    top uut (
        .clock(clock),
        .reset(reset),
        .writedataM(writedata),
        .dataAdrM(dataAdr),
        .memwriteM(memwrite)
    );

    initial begin
        reset <= 1;
        #100;
        reset <= 0;
        $display("Start");
        #1000; 
        $display("Value of ALU = %d", dataAdr);
        $finish;
    end

    always #10 clock <= ~clock;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
endmodule

		

