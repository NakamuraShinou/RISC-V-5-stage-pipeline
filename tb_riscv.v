module tb_riscv;
	
	reg clk, rst_pc;
	
	wire [31:0] inst;
	wire [31:0] inst_d;
	wire [31:0] inst_x;
	wire [31:0] inst_m;
	wire [31:0] inst_w;

	wire [31:0] Out_PC;

	wire [31:0] pc_d;
	wire [31:0] Data_A;
	wire [31:0] Data_B;
	
	wire BrUn_x, ASel_x, BSel_x;
	wire [2:0] ImmSel_x;
	wire [3:0] ALU_Sel_x;
	wire [31:0] pc_x;
	wire [31:0] rs1_x;
	wire [31:0] rs2_x;
	wire [31:0] Imm;
	wire [31:0] alu;
	wire [1:0] selA_fwd, selB_fwd;
	
	wire [3:0] MemRW_m;
	wire [1:0] WBSel_m;
	wire [31:0] pc_m;
	wire [31:0] alu_m;
	wire [31:0] rs2_m;
	
	
	wire RegWEn_w;
	wire [31:0] wb_w;

	wire [4:0] rst_clt, en_clt;
	

	initial begin
		#1
		clk = 1'b0;
		forever #5 clk = ~clk;
	end 
	
	initial begin
		#0
			rst_pc = 1'b0;
		#10
			rst_pc = 1'b1;
	end
	
	always @(inst_w) begin
		if (inst_w == 32'h00000033)
			$finish;
	end
	
	TOP_DE2 test(
    clk,
    rst_pc
	);
	
	assign inst = test.inst;
	assign Out_PC = test.Out_PC;
	assign pc_d = test.pc_d;
	assign inst_d = test.inst_d;
	assign Data_A = test.Data_A;
	assign Data_B = test.Data_B;
	
	assign BrUn_x = test.BrUn_x, ASel_x = test.ASel_x, BSel_x = test.BSel_x;
	assign ImmSel_x = test.ImmSel_x;
	assign ALU_Sel_x = test.ALU_Sel_x;
	assign pc_x = test.pc_x;
	assign rs1_x = test.rs1_x;
	assign rs2_x = test.rs2_x;
	assign inst_x = test.inst_x;
	assign Imm = test.Imm;
	assign alu = test.alu;
	assign selA_fwd = test.selA_fwd;
	assign selB_fwd = test.selB_fwd;
	
	assign MemRW_m = test.MemRW_m;
	assign WBSel_m = test.WBSel_m;
	assign pc_m = test.pc_m;
	assign alu_m = test.alu_m;
	assign rs2_m = test.rs2_m;
	assign inst_m = test.inst_m;
	
	assign RegWEn_w = test.RegWEn_w;
	assign inst_w = test.inst_w;
	assign wb_w = test.wb_w; 
	
	assign rst_clt = test.rst_clt;
	assign en_clt = test.en_clt;
endmodule 