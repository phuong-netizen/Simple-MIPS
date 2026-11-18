module reg_file (
    input [4:0] rr1,
    input [4:0] rr2,
    input [4:0] Wri_reg,
    input clk,
    input [31:0] Wri_data,
    input reg_wri,
    input rstn,
    output [31:0] rd1,
    output [31:0] rd2
);
    reg [31:0] regs [0:31];
    integer i;
    always@ (posedge clk or negedge rstn) begin 
        if (~rstn) begin
            for (i = 0; i < 32; i = i + 1) begin
                regs[i] <= 32'd0;
            end 
        end 
        else if ((reg_wri) && (Wri_reg != 0)) begin
            regs[Wri_reg] <= Wri_data;
        end  
    end
    assign rd1 = regs[rr1];
    assign rd2 = regs[rr2];
endmodule
