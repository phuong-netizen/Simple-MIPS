module sign_extend (
    input [15:0] A,
    input mode,
    output [31:0] O
);
assign O = (mode) ? {{16{A[15]}}, A} : {16'h0, A} ;
endmodule