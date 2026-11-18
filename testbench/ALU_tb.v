module ALU_tb;
    reg [31:0] A;
    reg [31:0] B;
    reg [3:0] ALUcon;
    wire isZero;
    wire [31:0] Res;
    wire overflow;

    ALU dut(
        .A(A),
        .B(B),
        .ALUcon(ALUcon),
        .isZero(isZero),
        .Res(Res),
        .overflow(overflow)
    );

    initial begin
        A = 0;
        B = 0;
        ALUcon = 0;
        #10
        A = 32'h000000AB;
        B = 32'h00000067;
        ALUcon = 4'b0000;
        #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
        ALUcon = ALUcon +4'b1; #10
    // overflow ADD
    //positive
        A = 32'h7FFFFFFF;
        B = 32'h1;
        ALUcon = 4'b0101;
    #10
    // Negative
        A = 32'h80000000;
        B = 32'hFFFFFFFF;
        ALUcon = 4'b0101;
    #10
    // overflow SUB
    // Positive
        A = 32'h7FFFFFFF;
        B = 32'hFFFFFFFF;
        ALUcon = 4'b0110;
    #10

    // Negative 
        A = 32'h80000000;
        B = 32'h1;
        ALUcon = 4'b0110;
    #10

    //INC
        A = 32'h7FFFFFFF;
        ALUcon = 4'b0111;
    #10

    //DEC
        A = 32'h80000000;
        ALUcon = 4'b0100;
    #10

    $finish;

    end


        




