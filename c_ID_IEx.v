module c_ID_IEx (
    input clock,
    input reset,
    input clear,
    input RegWriteD,
    input memwriteD,
    input JumpD,
    input BranchD,
    input ALUSrcAD,
    input [1:0] ALUSrcBD,
    input [1:0] ResultSrcD,
    input [3:0] ALUcontrolD,
    output reg RegWriteE,
    output reg memwriteE,
    output reg JumpE,
    output reg BranchE,
    output reg  ALUSrcAE,
    output reg [1:0] ALUSrcBE,
    output reg [1:0] ResultSrcE,
    output reg [3:0] ALUcontrolE
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            RegWriteE 	<= 0;
            memwriteE 	<= 0;
            JumpE 	  	<= 0;
            BranchE   	<= 0;
            ALUSrcAE  	<= 0; 
            ALUSrcBE    <= 0; 
            ResultSrcE  <= 0; 
            ALUcontrolE <= 0; 
        end else begin
            
            if (!clear) begin
                RegWriteE 	<= RegWriteD;
                memwriteE 	<= memwriteD;
                JumpE 	  	<= JumpD;
                BranchE	  	<= BranchD;
                ALUSrcAE  	<= ALUSrcAD;
                ALUSrcBE    <= ALUSrcBD;
                ResultSrcE  <= ResultSrcD;
                ALUcontrolE <= ALUcontrolD;
            end
        end
    end

endmodule