module reg_Nbits #(
parameter     N = 8
)
(
//Input
input		clk,
input           rst,
input           en,
input   [N-1:0] D,
//Output
output reg [N-1:0] Q 
);

always@(posedge clk)
begin
  if(!rst)
    Q <= {N{1'b0}};
  else 
    if (en)
    Q <= D;
end

endmodule 