module fwd_clt (
	input [31:0] inst_d,
	input [31:0] inst_x,
	input [31:0] inst_m,
	input [31:0] inst_w,
	//input is_jump,
	
	output reg [1:0] selA_fwd,
	output reg [1:0] selB_fwd,
	
	output selA_d,
	output selB_d,
	
	output reg [1:0] sel_sw,
	
	output reg [3:0] D_X_M_W
);

	wire [4:0] rd_x, rd_m, rd_w, rs1_x, rs2_x, rs1_d, rs2_d;
	
	assign rd_x = inst_x[11:7];
	assign rd_m = inst_m[11:7];
	assign rd_w = inst_w[11:7];
	assign rs1_x = inst_x[19:15];
	assign rs2_x = inst_x[24:20];
	assign rs1_d = inst_d[19:15];
	assign rs2_d = inst_d[24:20];
	
	wire is_rd_m, is_ld_m;
	assign is_rd_m = ((inst_m[6:0] == 7'b0110011) || 			//type R
							(inst_m[6:0] == 7'b0010011) || 		//type I calculate
							(inst_m[6:0] == 7'b1100111) ||		//JALR
							(inst_m[6:0] == 7'b1101111) ||		//JAL
							(inst_m[6:0] == 7'b0010111) ||		//AUIPC
							(inst_m[6:0] == 7'b0110111));		//LUI
	assign is_ld_m = (inst_m[6:0] == 7'b0000011);				//type I Data
	
	wire is_rd_w;
	assign is_rd_w = ((inst_w[6:0] == 7'b0110011) || 			//type R
							(inst_w[6:0] == 7'b0010011) || 		//type I calculate
							(inst_w[6:0] == 7'b1100111) ||		//JALR
							(inst_w[6:0] == 7'b1101111) ||		//JAL
							(inst_w[6:0] == 7'b0010111) ||		//AUIPC
							(inst_w[6:0] == 7'b0110111) ||		//LUI
							(inst_w[6:0] == 7'b0000011));		//type I Data
	
	wire is_rs1_x, is_rs2_x;
	assign is_rs1_x = ((inst_x[6:0] != 7'b0110111) &&			//LUI
							 (inst_x[6:0] != 7'b0010111) &&		//AUIPC
							 (inst_x[6:0] != 7'b1101111));		//JAL
							 
	assign is_rs2_x = ((inst_x[6:0] != 7'b0110111) &&			//LUI
							 (inst_x[6:0] != 7'b0010111) &&		//AUIPC
							 (inst_x[6:0] != 7'b1101111) &&		//JAL
							 (inst_x[6:0] != 7'b1100111) &&		//JALR
							 (inst_x[6:0] != 7'b0000011) &&		//type I Data
							 (inst_x[6:0] != 7'b0010011));		//type I calculate
	
	wire is_ld_x;
	assign is_ld_x = (inst_x[6:0] == 7'b0000011);				//type I Data
	
	wire is_rs1_d, is_rs2_d;
	assign is_rs1_d = ((inst_d[6:0] != 7'b0110111) &&			//LUI
							 (inst_d[6:0] != 7'b0010111) &&		//AUIPC
							 (inst_d[6:0] != 7'b1101111));		//JAL
							
	assign is_rs2_d = ((inst_d[6:0] != 7'b0110111) &&			//type R
							 (inst_d[6:0] != 7'b0010111) &&		//AUIPC
							 (inst_d[6:0] != 7'b1101111) &&		//JAL
							 (inst_d[6:0] != 7'b1100111) &&		//JALR
							 (inst_d[6:0] != 7'b0000011) &&		//type T Data
							 (inst_d[6:0] != 7'b0010011));		//type I calculate

	always @(*) begin
		if 	  (((rd_m == rs1_x && is_rd_m && is_rs1_x) || (rd_m == rs2_x && is_rd_m && is_rs2_x)) && (rd_m != 5'd0 || rd_w != 5'd0)) begin
			selA_fwd = (rd_m == rs1_x && rd_m != 5'd0) ? 2'd1 : (rd_w == rs1_x && rd_w != 5'd0) ? 2'd2 : 2'd0;
			selB_fwd = (rd_m == rs2_x && rd_m != 5'd0) ? 2'd1 : (rd_w == rs2_x && rd_w != 5'd0) ? 2'd2 : 2'd0;
			D_X_M_W = 3'b0;
		end
		else if (((rd_x == rs1_d && is_ld_x && is_rs1_d) || (rd_x == rs2_d && is_ld_x && is_rs2_d)) && rd_x != 5'd0) begin 
			D_X_M_W = 4'b100;
			selA_fwd = 2'd0;
			selB_fwd = 2'd0;
		end
		else if (((rd_w == rs1_x && is_rd_w && is_rs1_x) || (rd_w == rs2_x && is_rd_w && is_rs2_x)) && rd_w != 5'd0) begin
			selA_fwd = (rd_w == rs1_x) ? 2'd2 : 2'd0;
			selB_fwd = (rd_w == rs2_x) ? 2'd2 : 2'd0;
			D_X_M_W = 3'b0;
		end
		else begin
			selA_fwd = 2'b0;
			selB_fwd = 2'b0;
			D_X_M_W = 3'b0;
		end
	end
	
	assign selA_d = (rd_w == rs1_d && is_rd_w && is_rs1_d && rd_w != 5'd0);	//>.<
	assign selB_d = (rd_w == rs2_d && is_rd_w && is_rs2_d && rd_w != 5'd0);	//>.<
	
	wire is_sw;
	assign is_sw = (inst_x[6:0] == 7'b0100011);
	always @(*) begin
		if (rd_m == rs2_x && is_sw && is_rd_m && rd_m != 5'd0) sel_sw = 2'd1;
		else if (rd_w == rs2_x && is_sw && is_rd_w && rd_w != 5'd0) sel_sw = 2'd2;
		else sel_sw = 2'd0;
	end
	// always @(*) begin
	// 	D_X_M_W[3] = is_jump;
	// end
endmodule

// khoi nay chi stall tang x
// co the gop de stall cho branch
// brach stall tang d => dieu khien rieng