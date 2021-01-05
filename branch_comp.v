 module Branch_Comp (A,B,BrUn,BrEq,BrLT);
 input [31:0] A,B;
 input BrUn ;
 output BrEq,BrLT;

assign BrEq = (A == B);
assign BrLT = (BrUn) ? (A < B) : (({A[31], B[31]} == 2'b10) || ((A[31] == B[31]) && (A < B)));
endmodule 