module REG (
    input clock,
	 input rst_n,
    input regWEn,
    input [4:0] addr_A,
    input [4:0] addr_B,
    input [4:0] addr_D,
    input [31:0] data_D,
    output [31:0] data_A,
    output [31:0] data_B
 );

parameter REG_SIZE = 32;
integer i;
reg [31:0] memory [0:REG_SIZE-1];
assign data_A = memory [addr_A];
assign data_B = memory [addr_B];

always @(posedge clock, negedge rst_n) begin
	if (!rst_n) begin
		for (i = 0; i < REG_SIZE; i = i + 1) begin
			if (i == 2) memory[i] = 32'h2ffc;
			else if (i == 3) memory[i] = 32'h1800;
			else memory[i] = 0;
		end
	end
	else begin
		if(regWEn) 
			memory [addr_D] = (addr_D == 0) ? 0 : data_D;
	end
end
endmodule 