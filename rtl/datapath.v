`include "ALU.v"
`include "reg_file.v"
`include "sign_extend.v"
`include "jump_sign_ext.v"
`include "adder.v"
`include "data_mem.v"

module datapath (clk, rstn, instr_addr, pc_address, instr, overflow, isZero, RegDst, MemRead, MemtoReg, aluControl, MemWrite, ALUSrc, RegWrite, shamtSel, pcSrc, sign_ext_mode, signextSrc);
    input clk;
    input rstn, RegDst, ALUSrc, RegWrite, shamtSel, pcSrc, signextSrc , MemRead, MemtoReg, MemWrite, sign_ext_mode ;
    input [3:0] aluControl;
    input [31:0] instr;
    input [9:0] pc_address;
    output [9:0] instr_addr;
    output overflow, isZero;

    wire [4:0] rf_w_addr;
    wire [31:0] outp_se, outp_jse, rdat2_se, inpB_alu, outp_alu, rdat2, rdat1, outp_se_jse, branch_adder_outp, rdat_dmem, inp_wrdata_rf;
    wire [9:0] pc_addr_mux;

    mux2_1 #(.WIDTH(5)) wr_addr_mux(
        .A(instr[20:16]),
        .B(instr[15:11]),
        .Sel(RegDst),
        .O(rf_w_addr)
        );
    mux2_1 #(.WIDTH(32)) mem2reg_mux(
        .A(outp_alu),
        .B(rdat_dmem),
        .Sel(MemtoReg),
        .O(inp_wrdata_rf)
        );
    mux2_1 #(.WIDTH(32)) rdat2_se_mux(
        .A(rdat2),
        .B(outp_se),
        .Sel(ALUSrc),
        .O(rdat2_se)
        );
    mux2_1 #(.WIDTH(32)) shamt_mux(
        .A(rdat2_se),
        .B({27'd0, instr[10:6]}),
        .Sel(shamtSel),
        .O(inpB_alu)
        );
    mux2_1 #(.WIDTH(32)) signext_mux(
        .A(outp_se),
        .B(outp_jse),
        .Sel(signextSrc),
        .O(outp_se_jse)
        );
    mux2_1 #(.WIDTH(10)) pcSrc_mux(
        .A(pc_address),
        .B(branch_adder_outp [9:0]),
        .Sel(pcSrc),
        .O(pc_addr_mux)
        );
    reg_file rf(
        .rr1(instr[25:21]),
        .rr2(instr[20:16]),
        .Wri_reg(rf_w_addr),
        .clk(clk),
        .Wri_data(inp_wrdata_rf),
        .reg_wri(RegWrite),
        .rstn(rstn),
        .rd1(rdat1),
        .rd2(rdat2)
        );
    ALU ALU(
        .A(rdat1),
        .B(inpB_alu),
        .ALUcon(aluControl),
        .isZero(isZero),
        .Res(outp_alu),
        .overflow(overflow)
        );
    data_mem dmem(
        .clk(clk),
        .rstn(rstn),
        .memRead(MemRead),
        .memWrite(MemWrite),
        .addr(outp_alu),
        .wr_data(rdat2 ),
        .r_data(rdat_dmem)
        );
    sign_ext se(
        .A(instr[15:0]),
        .mode(sign_ext_mode),
        .O(outp_se)
        );
    jump_sign_ext jse(
        .A(instr[25:0]),
        .O(outp_jse)
        );

    adder branch_adder(
        .A({22'd0, pc_address}),
        .B(outp_se_jse),
        .Res(branch_adder_outp)
        );

    adder pc_adder(
        .A(pc_addr_mux),
        .B(10'd1),
        .Res(instr_addr)
        );
endmodule