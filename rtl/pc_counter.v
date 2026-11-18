module pc_counter (
    input clk, 
    input rstn,
    input inc,
    input [9:0] pre_pc,
    output [9:0] curr_pc
);
reg [9:0] pc_reg;
    always@ (posedge clk or negedge rstn) begin
        if (~rstn) begin
            pc_reg <= 10'd0;
        end
        else if (inc) begin
            pc_reg <= pre_pc + 1'b1;
        end
        else begin
            pc_reg <= pre_pc;
        end
    end
assign curr_pc = pc_reg ;
endmodule
