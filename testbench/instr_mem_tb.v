`timescale 1ns/1ps

module instr_mem_tb;

    reg  [9:0] rd_addr;
    reg        rstn;
    reg        clk;
    reg        rd_en;

    wire [31:0] instr;

    instr_mem dut (
        .rd_addr(rd_addr),
        .rstn(rstn),
        .clk(clk),
        .rd_en(rd_en),
        .instr(instr)
    );

    always #5 clk = ~clk;

    initial begin
        clk     = 0;
        rstn    = 0;
        rd_en   = 0;
        rd_addr = 0;

        #10;

        rstn = 1;

        rd_en = 0;
        rd_addr = 10'd0;
        #10;

        rd_en = 1;

        rd_addr = 10'd0;
        #10;

        rd_addr = 10'd1;
        #10;

        rd_addr = 10'd2;
        #10;

        rd_addr = 10'd3;
        #10;

        rd_addr = 10'd4;
        #10;

        rd_addr = 10'd5;
        #10;

        rd_en = 0;
        rd_addr = 10'd6;
        #10;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t rstn=%b rd_en=%b rd_addr=%0d instr=%h",
            $time, rstn, rd_en, rd_addr, instr
        );
    end

endmodule