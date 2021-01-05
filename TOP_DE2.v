module TOP_DE2 (
    input clock_in,
    input rst_pc
);
wire PCSel;
wire [31:0] PC_plus_4;
wire [31:0] alu;
wire [31:0] In_PC;
wire [31:0] Out_PC;
wire [31:0] inst;
wire [2:0] ImmSel;
wire  RegWEn;
wire [31:0] Imm;
wire BrUn;
wire BrEq;
wire BrLT;
wire [31:0] Data_A;
wire [31:0] Data_B;
wire ASel;
wire BSel;
wire [31:0] alu_A;
wire [31:0] alu_B;
wire [3:0] ALU_Sel;
wire [3:0] MemRW;
wire [1:0] WBSel;
wire [31:0] mem;
wire [31:0] wb;

wire clock;

wire [3:0] D_X_M_W_clt;

assign clock = 1'b1 && clock_in;

wire [4:0] rst_clt, en_clt;
stall_clt stall(clock, rst_pc, {1'b0, D_X_M_W_clt}, rst_clt, en_clt);

////////////// Fetch stage /////////////////////
wire is_jump;
// assign PCSel_f = PCSel;

assign PC_plus_4 = ((is_jump) ? alu : Out_PC) + 32'd4;
//MUX block_1 (1'b0,{1'b0,PCSel},PC_plus_4,alu,32'd0,32'd0,In_PC);
assign In_PC = PC_plus_4;
PC block_PC (clock, rst_pc & rst_clt[4], en_clt[4], In_PC, Out_PC);
IMEM block_IMEM (inst, (is_jump) ? alu : Out_PC);

wire [31:0] pc_d;
reg_Nbits #(32) u1(clock, rst_pc & rst_clt[3], en_clt[3], (is_jump) ? alu : Out_PC, pc_d);

wire [31:0] inst_d;
reg_Nbits #(32) u2(clock, rst_pc & rst_clt[3], en_clt[3], inst, inst_d);
////////////////////////////////////////////////


////////////// Decode stage ////////////////////
wire RegWEn_w;
wire [31:0] inst_w;
wire [31:0] wb_w;
wire selA_d, selB_d;

REG block_REG (clock,rst_pc,RegWEn_w,inst_d[19:15],inst_d[24:20],inst_w[11:7],wb_w,Data_A,Data_B);

wire [31:0] pc_x;
reg_Nbits #(32) u3(clock, rst_pc & rst_clt[2] & (!is_jump), en_clt[2], pc_d, pc_x);

wire [31:0] rs1_x;
reg_Nbits #(32) u4(clock, rst_pc & rst_clt[2] & (!is_jump), en_clt[2], (selA_d) ? wb_w : Data_A, rs1_x);

wire [31:0] rs2_x;
reg_Nbits #(32) u5(clock, rst_pc & rst_clt[2] & (!is_jump), en_clt[2], (selB_d) ? wb_w : Data_B, rs2_x);

wire [31:0] inst_x;
reg_Nbits #(32) u6(clock, rst_pc & rst_clt[2] & (!is_jump), en_clt[2], inst_d, inst_x);
////////////////////////////////////////////////


////////////// Excute stage ////////////////////
wire BrUn_x, ASel_x, BSel_x;
wire [2:0] ImmSel_x; 
wire [3:0] ALU_Sel_x;
wire [1:0] sel_sw;

wire [31:0] pc_m;
reg_Nbits #(32) u7(clock, rst_pc & rst_clt[1], en_clt[1], pc_x, pc_m);

wire [31:0] alu_m;
reg_Nbits #(32) u8(clock, rst_pc & rst_clt[1], en_clt[1], alu, alu_m);

wire [31:0] rs2_m;
reg_Nbits #(32) u9(clock, rst_pc & rst_clt[1], en_clt[1], (sel_sw[1]) ? wb_w : (sel_sw[0]) ? alu_m : rs2_x, rs2_m);

wire [31:0] inst_m;
reg_Nbits #(32) u10(clock, rst_pc & rst_clt[1], en_clt[1], inst_x, inst_m);

wire [1:0] selA_fwd, selB_fwd;

Branch_Comp block_B_C (((selA_fwd[1]) ? wb_w : (selA_fwd[0]) ? alu_m : rs1_x),((selB_fwd[1]) ? wb_w : (selB_fwd[0]) ? alu_m : rs2_x),BrUn_x,BrEq,BrLT);
ImmGen block_ImmGen (inst_x[31:7],ImmSel_x,Imm);
//MUX block_2 (1'b0,{1'b0,ASel},Data_A,Out_PC,32'd0,32'd0,alu_A);
assign alu_A = (ASel_x) ? pc_x : ((selA_fwd[1]) ? wb_w : (selA_fwd[0]) ? alu_m : rs1_x);
//MUX block_3 (1'b0,{1'b0,BSel},Data_B,Imm,32'd0,32'd0,alu_B);
assign alu_B = (BSel_x) ? Imm : ((selB_fwd[1]) ? wb_w : (selB_fwd[0]) ? alu_m : rs2_x);
ALU block_ALU (ALU_Sel_x,alu_A,alu_B,alu);

branch_clt branch(BrEq,BrLT, inst_x, is_jump);
 
fwd_clt fwd(inst_d, inst_x, inst_m, inst_w, selA_fwd, selB_fwd, selA_d, selB_d, sel_sw, D_X_M_W_clt);
////////////////////////////////////////////////


////////////// Memory stage ////////////////////
wire [3:0] MemRW_m;
wire [1:0] WBSel_m;

DMEM block_DMEM (clock,rst_pc,MemRW_m,alu_m,rs2_m,mem);
MUX block_4 (WBSel_m, mem, alu_m, pc_m + 4, 32'dz, wb);

reg_Nbits #(32) u11(clock, rst_pc & rst_clt[0], en_clt[0], wb, wb_w);
reg_Nbits #(32) u12(clock, rst_pc & rst_clt[0], en_clt[0], inst_m, inst_w);
////////////////////////////////////////////////


wire [16:0] tmp_d;
wire [6:0] tmp_x;
wire tmp_w;

reg_Nbits #(17) u13(clock, rst_pc & rst_clt[3], en_clt[3], {BrUn, ASel, BSel, ImmSel, ALU_Sel, MemRW, WBSel, RegWEn}, tmp_d);
reg_Nbits #(17) u14(clock, rst_pc & rst_clt[2] & (!is_jump), en_clt[2], tmp_d, {BrUn_x, ASel_x, BSel_x, ImmSel_x, ALU_Sel_x, tmp_x});
reg_Nbits #(7) u15(clock, rst_pc & rst_clt[1], en_clt[1], tmp_x, {MemRW_m, WBSel_m, tmp_w});
reg_Nbits #(1) u16(clock, rst_pc & rst_clt[0], en_clt[0], tmp_w, RegWEn_w);

Control block_Control (inst,ImmSel,RegWEn,BrUn,BSel,ASel,ALU_Sel,MemRW,WBSel);
endmodule 