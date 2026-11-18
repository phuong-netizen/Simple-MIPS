module jump_sign_ext (A, O);
    input [25:0] A;
    output [31:0] O;
    
    assign O = {{6{A[25]}}, A};
endmodule
