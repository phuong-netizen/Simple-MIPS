module mux2_1 #(
    parameter WIDTH = 32
) (
    input [WIDTH - 1 : 0] A,
    input [WIDTH - 1 : 0] B,
    input Sel,
    output [WIDTH - 1 : 0] O
);
    assign O = (Sel) ? (B) : (A)  ;
endmodule