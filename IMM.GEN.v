module ImmGen (
    input [24:0] inst_31_7,
    input [2:0] ImmSel,
    output reg [31:0] Imm
);
always @(inst_31_7 or ImmSel) begin
  case (ImmSel) 
  3'd0: Imm <= {(inst_31_7 [24]==1'b1)?21'b111111111111111111111:21'd0,inst_31_7 [23:13]};
  3'd1: Imm <= {27'd0,inst_31_7 [17:13]};
  3'd2: Imm <= {(inst_31_7 [24]==1'b1)?21'b111111111111111111111:21'd0,inst_31_7 [23:18],inst_31_7 [4:0]};
  3'd3: Imm <= {{19{inst_31_7 [24]}},inst_31_7 [24], inst_31_7 [0],inst_31_7 [23:18],inst_31_7 [4:1],1'b0};
  3'd4: Imm <= {inst_31_7 [24:5],12'd0};
  3'd5: Imm <= {inst_31_7 [24:5],12'd0};
  3'd6: Imm <= {{11{inst_31_7 [24]}},inst_31_7 [24],inst_31_7 [12:5],inst_31_7 [13],inst_31_7 [23:14],1'b0};
  3'd7: Imm <= {{20{inst_31_7 [24]}},inst_31_7 [24:13]};
  endcase
end
endmodule