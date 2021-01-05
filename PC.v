module PC(
    input clock,
	 input rst,
	 input en,
    input [31:0] port_in,
    output reg [31:0] port_out
);
always @(posedge clock, negedge rst) begin
  if(!rst) begin
		port_out =32'd0;
  end
  else if (en)
		port_out <= port_in;
end
endmodule