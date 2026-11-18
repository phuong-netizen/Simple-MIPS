module data_mem (
    input clk,
    input rstn,
    input memRead,
    input memWrite,
    input [31:0] addr,
    input [31:0] wr_data,
    output [31:0] r_data
);
    reg [31:0] mem_arr [0:1023];
    reg [31:0] mem_reg;
    integer i;
    always@ (posedge clk or negedge rstn) begin
        if (~rstn) begin
            mem_reg <= 32'h0;
            for (i = 0; i < 1024; i = i +1 ) begin
                mem_arr[i] <= 32'h0;
            end
        end
        else if (memWrite) begin
            mem_arr[addr] <= wr_data ;
        end
        else if (memRead) begin
            mem_reg <= mem_arr[addr];
        end
        else begin
            mem_reg <= mem_reg;
        end
    end
    assign r_data = mem_reg;
endmodule
            


