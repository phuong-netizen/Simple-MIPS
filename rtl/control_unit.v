module control_unit (rstn, opcode, funct, overflow, isZero, RegDst, MemRead, MemtoReg, aluControl, MemWrite, ALUSrc, RegWrite, shamtSel, pcSrc, sign_ext_mode, signextSrc);
    input rstn;
    input [5:0] opcode, funct;
    input overflow, isZero;
    output reg RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, shamtSel, pcSrc, signextSrc, sign_ext_mode;
    output reg [3:0] aluControl;

    localparam Arith_Logic_cmd  = 6'b000000;
    localparam Shift_cmd        = 6'b000001;
    localparam CMP_cmd          = 6'b000010;

    localparam ADDI_cmd         = 6'b100000;
    localparam SUBI_cmd         = 6'b100001;
    localparam ANDI_cmd         = 6'b100010;
    localparam ORI_cmd          = 6'b100011;
    localparam XORI_cmd         = 6'b100100;
    localparam SLTI_cmd         = 6'b100101;
    localparam SLTIU_cmd        = 6'b100110;
    localparam SEQI_cmd         = 6'b100111;
    localparam LW_cmd           = 6'b101000;
    localparam SW_cmd           = 6'b101001;
    localparam BEQ_cmd          = 6'b110000;
    localparam BNE_cmd          = 6'b110001;
    localparam JUMP_cmd         = 6'b111000;
    
    always @(*) begin
        if (~rstn) begin
            RegDst = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
            shamtSel =  1'b0;
            pcSrc = 1'b0;
            signextSrc =1'b0;
            aluControl =2'b11;
            sign_ext_mode = 1'b0;
        end
        else begin
            case(opcode) 
                Arith_Logic_cmd: begin
                    RegDst = 1'b1;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b1;
                    shamtSel =  1'b0; //Shift
                    sign_ext_mode = 1'b1; // mode sign
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    case (funct)
                        6'd0: begin             // ADD
                            aluControl = 4'b0101;
                        end 
                        6'd1: begin             // SUB
                            aluControl = 4'b0110;
                        end 
                        6'd2: begin             // INC
                            aluControl = 4'b0111;
                        end 
                        6'd3: begin             // DEC
                            aluControl = 4'b0100;
                        end 
                        6'd4: begin             // AND
                            aluControl = 4'b0001;
                        end 
                        6'd8: begin             // OR
                            aluControl = 4'b0011;
                        end 
                        6'd16: begin            // XOR
                            aluControl = 4'b0010;
                        end 
                        6'd32: begin            // NOT
                            aluControl = 4'b0000;
                        end 
                        default: begin
                            aluControl = 4'b1111;
                        end
                    endcase
                end
                Shift_cmd: begin
                    RegDst = 1'b1;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b1;
                    shamtSel =  1'b1; //Shift
                    sign_ext_mode = 1'b1; // mode sign
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    case (funct) 
                        6'd0: begin
                            aluControl = 4'b1000; //SLL
                        end
                        6'd1: begin
                            aluControl = 4'b1001; //SRL
                        end
                        6'd2: begin
                            aluControl = 4'b1010; //SRA
                        end
                    default : begin
                        aluControl = 4'b1111;
                    end
                    endcase
                end
                CMP_cmd: begin
                    RegDst = 1'b1;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b1;
                    shamtSel =  1'b1; //Shift
                    sign_ext_mode = 1'b1; // mode sign
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    case (funct)
                        6'd0: begin
                            aluControl = 4'b1011; //SLT
                        end
                        6'd1: begin
                            aluControl = 4'b1100; //SLTU
                        end
                        6'd2: begin
                            aluControl = 4'b1101; //SEQ
                        end
                    endcase
                ADDI_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;
                    shamtSel =  1'b0; //Shift
                    sign_ext_mode = 1'b1; // mode sign
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b0101;
                end
                SUBI_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b0110;
                end
                ANDI_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b0001;
                end
                ORI_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b0011;
                end
                XORI_cmd: begin 
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b0010;
                end
                SLTI_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b1011;
                end
                SLTIU_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b0; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b1100;
                end
                SEQI_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b1101;
                end
                LW_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b1;
                    MemtoReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b0101;
                end
                SW_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b0;
                    MemWrite = 1'b1;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;    
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    pcSrc = 1'b0;
                    signextSrc =1'b0;
                    aluControl = 4'b0101;
                end
                BEQ_cmd: begin
                    RegDst = 1'b1;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b0;   
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    signextSrc =1'b0;
                    aluControl = 4'b0110;  //SUB
                if (isZero == 1'b1) begin
                    pcSrc = 1'b1;
                    end
                else begin
                    pcSrc = 1'b0;
                    end
                end
                BNE_cmd: begin
                    RegDst = 1'b1;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b0;   
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1;
                    signextSrc =1'b0;
                    aluControl = 4'b0110;  
                if (isZero == 1'b0) begin
                    pcSrc = 1'b1;   
                    end
                else begin
                    pcSrc = 1'b0;
                    end
                end
                JUMP_cmd: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b1;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b0;   
                    shamtSel =  1'b0; 
                    sign_ext_mode = 1'b1; 
                    signextSrc =1'b1;
                    aluControl = 4'b1111;  
                    pcSrc = 1'b1;
                end
                default: begin
                    RegDst = 1'b0;
                    MemRead = 1'b0;
                    MemtoReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b0;   
                    shamtSel =  1'b0; //Shift
                    sign_ext_mode = 1'b0; 
                    signextSrc =1'b0;
                    aluControl = 4'b0000;  
                    pcSrc = 1'b0;
                end
            endcase
        end
    end
endmodule


                    
                

                








                

                


         


                    