module branch_clt(
    input BrEq, 
    input BrLT,
    input [31:0] inst_x,
    output is_jump
);
    assign is_jump = ((inst_x[6:0] == 7'b1100011 && inst_x[14:12] == 3'b000 && BrEq) ||
                     (inst_x[6:0] == 7'b1100011 && inst_x[14:12] == 3'b001 && !BrEq) ||
                     (inst_x[6:0] == 7'b1100011 && inst_x[14:12] == 3'b100 && BrLT) ||
                     (inst_x[6:0] == 7'b1100011 && inst_x[14:12] == 3'b101 && !BrLT) ||
                     (inst_x[6:0] == 7'b1100011 && inst_x[14:12] == 3'b110 && BrLT) ||
                     (inst_x[6:0] == 7'b1100011 && inst_x[14:12] == 3'b111 && !BrLT) ||
                     (inst_x[6:0] == 7'b1101111) ||
                     (inst_x[6:0] == 7'b1100111)); 
endmodule