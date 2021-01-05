module ALU (
    input [3:0] ALUsel,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] result
);

wire [31:0] add_result;
wire [31:0] subb_result;
wire [31:0] sll_result;
wire [31:0] slt_result;
wire [31:0] sltu_result;
wire [31:0] xor_result;
wire [31:0] srl_result;
wire [31:0] sra_result;
wire [31:0] or_result;
wire [31:0] and_result;
integer i;

assign add_result = A+B;
assign subb_result = A-B;
assign and_result = A & B;
assign or_result = A | B;
assign xor_result = A ^ B;
assign sltu_result = (A<B)?32'd1:32'd0;
assign slt_result = ((A[31]==0)&(B[31]==0))?(A<B)?32'd1:32'd0:((A[31]==1)&(B[31]==0))?32'd1:((A[31]==0)&(B[31]==1))?32'd0:((A[31]==1)&(B[31]==1))?((~A+1)>(~B+1))?32'd1:32'd0:32'd0;
assign sll_result = A << B ;
assign srl_result = A >> B ;
assign sra_result = (A>>B) | (({32{A[31]}}) << (32 - B));

/*always @(A or B) begin
  temp = A;  
  for (i=0; i<B; i=i+1) begin
    if (A[31]==0)
      temp = temp >> 1;
    else
      temp = {1'b1,temp[31:1]};
  end
  sra_result = temp;
end*/

always @(*) begin
  case (ALUsel)
  4'd0: result <= add_result;
  4'd1: result <= subb_result;
  4'd2: result <= sll_result;
  4'd3: result <= slt_result;
  4'd4: result <= sltu_result;
  4'd5: result <= xor_result;
  4'd6: result <= srl_result;
  4'd7: result <= sra_result;
  4'd8: result <= or_result;
  4'd9: result <= and_result;
  default: result <= B;
  endcase
end
endmodule
