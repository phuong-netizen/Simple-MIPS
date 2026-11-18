module instr_mem (
    input  [9:0] rd_addr,
    input rstn,
    input clk,
    input rd_en,
    output [31:0] instr
);

reg [31:0] mem_arr [0:1023]; // 1024 o nho moi o nho chua 32 bit 
reg [31:0] mem_reg ;
integer i;
initial begin
    $readmemh("instruction.mem", mem_arr);
end
    always@ (posedge clk or negedge rstn) begin
        if (~rstn) begin
            mem_reg <= 32'd0;
            for (i = 0; i<1024; i = i + 1) begin
                mem_arr[i] <= 32'h0;
            end
        end 
        else if (rd_en) begin
            mem_reg <= mem_arr[rd_addr];
        end
        else begin
            mem_reg <= mem_reg;
        end
    end
    assign instr = mem_reg;
endmodule
