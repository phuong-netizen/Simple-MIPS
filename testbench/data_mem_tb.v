module data_mem_tb;

    reg clk, rst_n, memRead, memWrite;
    reg [31:0] addr;
    reg [31:0] wr_data;
    output [31:0] r_data;

    data_mem dut(
        .clk(clk),
        .rst_n(rst_n),
        .memRead(memRead),
        .memWrite(memWrite),
        .addr(addr),
        .wr_data(wr_data),
        .r_data(r_data)
    );

    always #5 clk = ~clk; 

    initial begin
        clk = 0;
        rst_n = 0;
        memRead = 0;
        memWrite = 0;
        addr = 0;
        wr_data = 0;

        #10
        // write tranfer 
        rst_n = 1;
        memRead = 0;
        memWrite = 1'b1;
        addr = 32'd1;
        wr_data = 32'h00000076;
        
        #10
        addr = 32'd2;
        wr_data = 32'h00000FFF;
        #10
        addr = 32'd3;
        wr_data = 32'h00000ABC;

        #10
        //Read tranfer 
        memRead = 1'b1;
        memWrite = 0;
        addr = 32'd1;

        #10 
        memWrite = 0;
        addr = 32'd2;

        #10 
        memRead = 1'b1;
        memWrite = 0;
        addr = 32'd3;

        #10 
        memRead = 1'b1;
        memWrite = 0;
        addr = 32'd4;

        #10 
        rst_n = 1'b0;

        #20

        $finish;

    end

endmodule
