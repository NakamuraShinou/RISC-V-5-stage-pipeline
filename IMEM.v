module IMEM (inst,PC);
input [31:0] PC;
output reg  [31:0] inst;
reg [7:0] IMEM [0:262143];
wire [17:0] pWord;
wire [1:0] pByte;
assign pByte = PC[1:0];

initial begin
 
  $readmemh("full_test.txt",IMEM);

end
always@(PC) begin
  if (pByte == 2'b00) begin
  inst[7:0] <= IMEM [PC+3];
  inst[15:8] <= IMEM [PC+2];
  inst[23:16] <= IMEM [PC+1];
  inst[31:24] <= IMEM [PC];
  end
  else
  inst <= 32'hz;
end
endmodule