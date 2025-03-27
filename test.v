// ================================================
// DSP48E2 Primitive Multiply-Add Test
// ================================================

module dsp48e2_mult_add (
    input wire CLK,
    input wire [17:0] A,
    input wire [17:0] B,
    input wire [47:0] C,
    output wire [47:0] P
);

  DSP48E2 #(
    .AREG(1),
    .BREG(1),
    .CREG(1),
    .MREG(1),
    .PREG(1),
    .USE_MULT("MULTIPLY"),
    .USE_SIMD("ONE48"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .ACASCREG(1),
    .BCASCREG(1),
    .INMODEREG(1),
    .OPMODEREG(1),
    .ALUMODEREG(1),
    .CARRYINREG(1),
    .CARRYINSELREG(1),
    .MASK(48'h3FFFFFFFFFFF),
    .PATTERN(48'h000000000000),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN")
  ) dsp48_inst (
    .A(A),
    .B(B),
    .C(C),
    .CLK(CLK),
    .P(P),
    .CEA1(1'b1), .CEA2(1'b1),
    .CEB1(1'b1), .CEB2(1'b1),
    .CEC(1'b1),
    .CEM(1'b1),
    .CEP(1'b1),
    .INMODE(5'b00000),
    .OPMODE(7'b0000101), // A*B + C
    .ALUMODE(4'b0000),
    .CARRYIN(1'b0),
    .CARRYINSEL(3'b000),
    .RSTA(1'b0), .RSTB(1'b0), .RSTC(1'b0), .RSTM(1'b0), .RSTP(1'b0),
    .RSTINMODE(1'b0), .RSTALLCARRYIN(1'b0), .RSTCTRL(1'b0), .RSTALUMODE(1'b0),
    .RSTCARRYIN(1'b0),
    .ACOUT(), .BCOUT(), .CARRYCASCOUT(), .MULTSIGNOUT(), .OVERFLOW(), .PATTERNBDETECT(),
    .PATTERNDETECT(), .PCOUT(), .UNDERFLOW(),
    .CARRYCASCIN(1'b0), .MULTSIGNIN(1'b0), .ACIN(30'b0), .BCIN(18'b0)
  );

endmodule

// =====================================================
// Testbench
// =====================================================

module tb_dsp48e2;
  reg CLK = 0;
  reg [17:0] A;
  reg [17:0] B;
  reg [47:0] C;
  wire [47:0] P;

  // Instantiate DUT
  dsp48e2_mult_add dut (
    .CLK(CLK),
    .A(A),
    .B(B),
    .C(C),
    .P(P)
  );

  // Clock generator
  always #5 CLK = ~CLK; // 100MHz

  initial begin
    $display("Time\tA\tB\tC\tP");
    $monitor("%0t\t%0d\t%0d\t%0d\t%0d", $time, A, B, C, P);

    // Test 1
    A = 18'd2;
    B = 18'd3;
    C = 48'd1;
    #20;

    // Test 2
    A = 18'd100;
    B = 18'd10;
    C = 48'd5;
    #20;

    // Test 3
    A = 18'd0;
    B = 18'd999;
    C = 48'd123;
    #20;

    $finish;
  end
endmodule