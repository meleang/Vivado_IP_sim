`timescale 1ns/1ps
module tb_dsp;

  // 입력 신호 정의
  reg clk = 0;
  reg [17:0] A;
  reg [17:0] B;
  reg [47:0] C;

  // 출력
  wire [47:0] P;

  // 클럭 생성 100MHz
  always #5 clk = ~clk;

  // DUT 인스턴스 (VEO 템플릿 기반)
  xbip_dsp48_macro_0 uut (
    .CLK(clk),
    .A(A),
    .B(B),
    .C(C),
    .P(P)
  );

  initial begin
    $display("A * B + C = P (누산 테스트)");
    
    // initialize
    A = 18'd2; B = 18'd3; C = 48'd0;  // 2*3 + 0 = 6
    #100;
    $display("P = %d", P);

    A = 18'd2; B = 18'd3; C = P;      // 2*3 + 6 = 12
    #100;
    $display("P = %d", P);

    A = 18'd2; B = 18'd3; C = P;      // 2*3 + 12 = 18
    #100;
    $display("P = %d", P);

    #100;
    $finish;
  end

endmodule
