module DMEM (
	 input clock,
	 input rst_n,
    input [3:0] MemRW,
    input [31:0] addr,
    input [31:0] DataW,
    output reg [31:0] DataR
);

parameter MEM_SIZE = 65536;
integer i;
reg  [7:0] memory [MEM_SIZE-1:0]; // [ffff:0]

always @(*) begin
	case (MemRW)
		4'd0: DataR = addr;
      4'd1: DataR = {(memory [addr] [7]==1'b0)?24'd0:24'b111111111111111111111111,memory [addr] };
      4'd2: DataR = {(memory [addr+1] [7]==1'b0)?16'd0:16'b1111111111111111,memory [addr+1] ,memory [addr] };
      4'd3: DataR = {memory [addr+3] ,memory [addr+2] ,memory [addr+1] ,memory [addr] };
      4'd4: DataR = {24'd0,memory [addr]};
      4'd5: DataR = {16'd0,memory [addr+1] ,memory [addr] };
		default: DataR = 0;
	endcase
end

// MemRw :10 is "read", 01 is :write" ,00 is "don't thing"
always @(posedge clock, negedge rst_n) begin
	if (!rst_n) begin
		for (i = 0; i < MEM_SIZE; i = i + 1) begin
			memory[i] = 8'b0;
		end
	end
	else begin
        if (MemRW[3])
            case (MemRW[2:0])
                4'd0: memory [addr] = DataW [7:0];
                4'd1: begin
                    memory [addr] = DataW [7:0];
                    memory [addr+1] = DataW [15:8];
                end
                default: begin
                    memory [addr] = DataW [7:0];
                    memory [addr+1] = DataW [15:8];
                    memory [addr+2] = DataW [23:16];
                    memory [addr+3] = DataW [31:24];
                end
            endcase
    end
end
endmodule 