`include "pc_counter.v"
`include "imem.v"
`include "control_unit.v"
`include "datapath.v"

module cpu (clk, rstn);
    input clk, rstn;
    wire RegDst, RegWrite, signextSrc, ALUSrc, shamtSel, pcSrc, MemRead, MemtoReg, MemWrite, sign_ext_mode, isZero, overflow;
    wire [31:0] instr; 
    wire [3:0] aluControl;
    wire [9:0] instr_addr, curr_pc, inp_addr_imem;

    pc_counter pc_counter(
    .clk(clk), 
    .rstn(rstn),
    .inc(pcSrc),
    .pre_pc(instr_addr),
    .curr_pc(curr_pc)
    );
    
    mux2_1 #(.WIDTH(10)) mux_addr_imem(
        .A(instr_addr),
        .B(curr_pc),
        .Sel(~pcSrc),
        .O(inp_addr_imem)
    );

    instr_mem imem(
        .rd_addr(inp_addr_imem),
        .rstn(rstn),
        .clk(clk),
        .rd_en(1'b1),
        .instr(instr)
    );

    datapath dtp(
        .clk(clk),
        .rstn(rstn),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .shamtSel(shamtSel),
        .pcSrc(pcSrc),
        .signextSrc(signextSrc),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .sign_ext_mode(sign_ext_mode),
        .aluControl(aluControl),
        .instr(instr),
        .pc_address(curr_pc),
        .instr_addr(instr_addr),
        .overflow(overflow),
        .isZero(isZero)    
    );

    control_unit cu(
        .rstn(rstn),
        .opcode(instr[31:26]),
        .funct(instr[5:0]),
        .overflow(overflow),
        .isZero(isZero),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite), 
        .shamtSel(shamtSel), 
        .pcSrc(pcSrc), 
        .signextSrc(signextSrc),
        .aluControl(aluControl),
        .sign_ext_mode(sign_ext_mode)
    );
endmodule


