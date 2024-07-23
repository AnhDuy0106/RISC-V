`timescale 1ns/1ns
`include "CPU"
`include "RegisterFile"
`include "InstructionMemory"
`include "DataMemory"
`include "ControlUnit"
`include "ProgramCounter"
`include "ALUControl"

module testbench();
    reg clk = 0;
    reg reset;

    CPU uut (
        .clk(clk),
        .reset(reset)
      	
    );

    always #10 clk = ~clk; 

    initial begin
        reset = 1;
        #100
        reset = 0; 
      	$display("Start");
        #1000; 
        $display("Value of ALU = %d", uut.alu.Result);
        $finish;

    end
  initial begin
    $dumpfile ("dump.vcd");
    $dumpvars(0);
  end
endmodule
