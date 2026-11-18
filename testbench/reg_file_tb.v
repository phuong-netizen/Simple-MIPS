module reg_file_tb;
    reg [4:0] rr1;
    reg [4:0] rr2;
    reg [4:0] Wri_reg;
    reg clk;
    reg [31:0] Wri_data;
    reg reg_wri;
    reg rstn;
    wire [31:0] rd1;
    wire [31:0] rd2;

    reg_file dut(
    .rr1(rr1),
    .rr2(rr2),
    .Wri_reg(Wri_reg),
    .clk(clk),
    .Wri_data(Wri_data),
    .reg_wri(reg_wri),
    .rstn(rstn),
    .rd1(rd1),
    .rd2(rd2)
    );

    always #5 clk = ~clk;

    initial begin
    rstn = 0;
    reg_wri = 0;
    rr1 = 0;
    rr2 = 0;
    Wri_reg = 0;
    clk = 0;
    Wri_data = 0;
    #10
    Wri_reg = 4'b0001;
    Wri_data = 32'h00000FFF;
    #10
    Wri_reg = 4'b0010;
    Wri_data = 32'h00000ABC;
    #10
    Wri_reg = 4'b0011;
    Wri_data = 32'h00000123;
    #10
    Wri_reg = 4'b0100;
    Wri_data = 32'h00000456;
    #10
    Wri_reg = 4'b0101;
    Wri_data = 32'h00000678;
    #10
    Wri_reg = 4'b0110;
    Wri_data = 32'h00000005;
    end

    initial begin
        #70
        reg_wri = 1;
        rr1 = 4'b0001;
        rr2 = 4'b0010;
        #10
        rr1 = 4'b0011;
        rr2 = 4'b0100;
        #30
        rr1 = 4'b0101;
        rr2 = 4'b0110;
        #10
        $finish;
    end
endmodule



