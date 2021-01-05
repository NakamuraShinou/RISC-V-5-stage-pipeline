module stall_clt(
	input clk,
	input rst_n,
	input [4:0] F_D_X_M_W_clt, 
	output [4:0] rst_clt,
	output [4:0] en_clt
	);

	wire w0, w1, w2, w3, w4;
	wire [4:0] en_clt_tmp, rst_clt_tmp;
	
	and u0(w0, ~F_D_X_M_W_clt[0], 1'b1);
	and u1(w1, ~F_D_X_M_W_clt[1], w0);
	and u2(w2, ~F_D_X_M_W_clt[2], w1);
	and u3(w3, ~F_D_X_M_W_clt[3], w2);
	and u4(w4, ~F_D_X_M_W_clt[4], w3);
	
	assign en_clt_tmp[0] = w0;
	assign en_clt_tmp[1] = w1;
	assign en_clt_tmp[2] = w2;
	assign en_clt_tmp[3] = w3;
	assign en_clt_tmp[4] = w4;
	
	assign rst_clt_tmp[0] = ~F_D_X_M_W_clt[0];
	assign rst_clt_tmp[1] = ~F_D_X_M_W_clt[1];
	assign rst_clt_tmp[2] = ~F_D_X_M_W_clt[2];
	assign rst_clt_tmp[3] = ~F_D_X_M_W_clt[3];
	assign rst_clt_tmp[4] = ~F_D_X_M_W_clt[4];
	
	assign en_clt = en_clt_tmp;
	assign rst_clt = rst_clt_tmp;
	/*
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			rst_clt = 5'b0;
			//en_clt = 5'b0;
		end
		else begin
			rst_clt = rst_clt_tmp;
			//en_clt = en_clt_tmp;
		end
	end*/
endmodule 