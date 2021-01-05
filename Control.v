module Control(
    input [31:0] inst,
    // input BrEq,
    // input BrLT,
    /*output reg PCsel,*/
    output reg [2:0] ImmSel,
    output reg RegWEn,
    output reg BrUn,
    output reg Bsel,
    output reg Asel,
    
    output reg [3:0] ALUSel,
    output reg [3:0] MemRW,
    output reg [1:0] WBsel
);
always @(*) begin
  casez ({inst [30],inst [14:12],inst [6:2]})
  //Type R
  9'b0_000_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0000,4'b0000,2'b01};
  9'b1_000_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0001,4'b0000,2'b01};
  9'b0_001_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0010,4'b0000,2'b01};
  9'b0_010_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0011,4'b0000,2'b01};
  9'b0_011_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0100,4'b0000,2'b01};
  9'b0_100_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0101,4'b0000,2'b01};
  9'b0_101_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0110,4'b0000,2'b01};
  9'b1_101_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b0111,4'b0000,2'b01};
  9'b0_110_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b1000,4'b0000,2'b01};
  9'b0_111_01100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,4'b1001,4'b0000,2'b01};
  //Type I cal
  9'b?_000_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0000,4'b0000,2'b01};
  9'b?_010_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0011,4'b0000,2'b01};
  9'b?_011_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0100,4'b0000,2'b01};
  9'b?_100_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0101,4'b0000,2'b01};
  9'b?_110_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b1000,4'b0000,2'b01};
  9'b?_111_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b1001,4'b0000,2'b01};
  9'b0_001_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b001,1'b1,1'b0,1'b1,1'b0,4'b0010,4'b0000,2'b01};
  9'b0_101_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b001,1'b1,1'b0,1'b1,1'b0,4'b0110,4'b0000,2'b01};
  9'b1_101_00100: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b001,1'b1,1'b0,1'b1,1'b0,4'b0111,4'b0000,2'b01};
  //Type I load
  9'b?_000_00000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0000,4'b0001,2'b00};
  9'b?_001_00000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0000,4'b0010,2'b00};
  9'b?_010_00000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0000,4'b0011,2'b00};
  9'b?_100_00000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0000,4'b0100,2'b00};
  9'b?_101_00000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b000,1'b1,1'b0,1'b1,1'b0,4'b0000,4'b0101,2'b00};
  //Type S
  9'b?_000_01000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b010,1'b0,1'b0,1'b1,1'b0,4'b0000,4'b1000,2'b11};
  9'b?_001_01000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b010,1'b0,1'b0,1'b1,1'b0,4'b0000,4'b1001,2'b11};
  9'b?_010_01000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b010,1'b0,1'b0,1'b1,1'b0,4'b0000,4'b1010,2'b11};
  //Type B
  9'b?_000_11000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b011,1'b0,1'b0,1'b1,1'b1,4'b0000,4'b0000,2'b11};
  9'b?_001_11000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b011,1'b0,1'b0,1'b1,1'b1,4'b0000,4'b0000,2'b11};
  9'b?_100_11000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b011,1'b0,1'b0,1'b1,1'b1,4'b0000,4'b0000,2'b11};
  9'b?_101_11000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b011,1'b0,1'b0,1'b1,1'b1,4'b0000,4'b0000,2'b11};
  9'b?_110_11000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b011,1'b0,1'b1,1'b1,1'b1,4'b0000,4'b0000,2'b11};
  9'b?_111_11000: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b011,1'b0,1'b1,1'b1,1'b1,4'b0000,4'b0000,2'b11};
  //Type U
  9'b?_???_01101: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b100,1'b1,1'b0,1'b1,1'b0,4'b1010,4'b0000,2'b01};
  9'b?_???_00101: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b0,3'b101,1'b1,1'b0,1'b1,1'b1,4'b0000,4'b0000,2'b01};
  //Type J
  9'b?_???_11011: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b1,3'b110,1'b1,1'b0,1'b1,1'b1,4'b0000,4'b0000,2'b10};
  9'b?_000_11001: {/*PCsel,*/ImmSel,RegWEn,BrUn,Bsel,Asel,ALUSel,MemRW,WBsel} <={1'b1,3'b111,1'b1,1'b0,1'b1,1'b0,4'b0000,4'b0000,2'b10};
  endcase
  end
endmodule