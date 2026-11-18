module ALU (
input [31:0] A,
input [31:0] B,
input [3:0] ALUcon,
output isZero,
output [31:0] Res,
output reg overflow
);
reg [31:0]  temp ;
wire [31:0] C;
wire [32:0] uA;
wire [32:0] uB;
wire [32:0] uC;
assign C = A + ~B + 32'h1;
assign uA = {1'b0, A};
assign uB = {1'b0, B};
assign uC = uA + ~uB + 33'b1;
always @(*) begin
    case (ALUcon)
        4'b0000: begin
            temp = ~A;
            overflow = 1'b0; //Not
        end
        4'b0001: begin
            temp = A & B;
            overflow = 1'b0; //And
        end
        4'b0010: begin
            temp = A ^ B;
            overflow = 1'b0; //Xor
        end
        4'b0011: begin
            temp = A | B;
            overflow = 1'b0; //Or
        end
        4'b0100: begin
            temp = A - 32'b1; //Dec
            overflow = ($signed(A) == $signed(32'h80000000)) ;
        end
        4'b0101: begin
            temp = A + B; //ADD
            overflow = (($signed(A) > 0 && $signed(B) > 0 && $signed(temp) < 0) || 
            ($signed(A) < 0 && $signed(B) < 0 && $signed(temp) > 0));
        end
        4'b0110: begin 
            temp = A - B; // SUB
            overflow = (($signed(A) > 0 && $signed(B) < 0 && $signed(temp) < 0) || 
            ($signed(A) < 0 && $signed(B) > 0 && $signed(temp) > 0));
        end
        4'b0111: begin
            temp = A + 32'b1; //INC
            overflow = ($signed(A) == $signed(32'h7FFFFFFF)) ;
        end
        4'b1000: begin
            temp = A << B[4:0];                  //SLL: shift left 
            overflow = 1'b0;
        end
        4'b1001: begin
            temp = A >> B[4:0];                 //SRL:shift right
            overflow = 1'b0;
        end
        4'b1010: begin
            temp = A >>> B[4:0];
            overflow = 1'b0;         //SRA
        end
        4'b1011: begin
            temp = (C[31] ^ (($signed(A) > 0 && $signed(B) < 0 && C[31] == 1) || 
            ($signed(A) > 0 && $signed(B) < 0 && C[31] ==0 ))  ) ? 32'h1 : 32'h0; //SLT
            overflow  = 1'b0;
        end
        4'b1100: begin  
            temp = (~uC[32]) ?  32'h1 : 32'h0;
            overflow = 1'b0; //
        end
        4'b1101: begin
            temp = (A == B) ? 32'h1 : 32'h0; //SEQ
            overflow = 1'b0;
        end
        default: begin
            temp = 32'h0;
            overflow = 1'b0;
        end
    endcase
end
assign Res = temp;
assign isZero = ~|temp;
endmodule