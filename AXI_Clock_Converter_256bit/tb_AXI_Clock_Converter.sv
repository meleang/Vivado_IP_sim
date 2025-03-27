`timescale 1ns/1ps
module tb_axi_clock_converter;

  // Clock and reset
  reg s_axi_aclk = 0;
  reg m_axi_aclk = 0;
  reg s_axi_aresetn = 0;
  reg m_axi_aresetn = 0;

  always #5  s_axi_aclk = ~s_axi_aclk; // 100MHz
  always #3.5 m_axi_aclk = ~m_axi_aclk; // ~143MHz

  // Slave AXI signals
  reg [31:0] s_axi_awaddr;
  reg [7:0]  s_axi_awlen;
  reg [2:0]  s_axi_awsize;
  reg [1:0]  s_axi_awburst;
  reg        s_axi_awlock;
  reg [3:0]  s_axi_awcache;
  reg [2:0]  s_axi_awprot;
  reg [3:0]  s_axi_awregion;
  reg [3:0]  s_axi_awqos;
  reg        s_axi_awvalid;
  wire       s_axi_awready;

  reg [255:0] s_axi_wdata;
  reg [31:0]  s_axi_wstrb;
  reg         s_axi_wlast;
  reg         s_axi_wvalid;
  wire        s_axi_wready;

  wire [1:0]  s_axi_bresp;
  wire        s_axi_bvalid;
  reg         s_axi_bready;

  reg [31:0] s_axi_araddr;
  reg [7:0]  s_axi_arlen;
  reg [2:0]  s_axi_arsize;
  reg [1:0]  s_axi_arburst;
  reg        s_axi_arlock;
  reg [3:0]  s_axi_arcache;
  reg [2:0]  s_axi_arprot;
  reg [3:0]  s_axi_arregion;
  reg [3:0]  s_axi_arqos;
  reg        s_axi_arvalid;
  wire       s_axi_arready;

  wire [255:0] s_axi_rdata;
  wire [1:0]   s_axi_rresp;
  wire         s_axi_rlast;
  wire         s_axi_rvalid;
  reg          s_axi_rready;

  // Master AXI signals
  wire [31:0] m_axi_awaddr;
  wire [7:0]  m_axi_awlen;
  wire [2:0]  m_axi_awsize;
  wire [1:0]  m_axi_awburst;
  wire        m_axi_awlock;
  wire [3:0]  m_axi_awcache;
  wire [2:0]  m_axi_awprot;
  wire [3:0]  m_axi_awregion;
  wire [3:0]  m_axi_awqos;
  wire        m_axi_awvalid;
  reg         m_axi_awready = 1;

  wire [255:0] m_axi_wdata;
  wire [31:0]  m_axi_wstrb;
  wire         m_axi_wlast;
  wire         m_axi_wvalid;
  reg          m_axi_wready = 1;

  reg [1:0]    m_axi_bresp = 0;
  reg          m_axi_bvalid = 0;
  wire         m_axi_bready;

  wire [31:0] m_axi_araddr;
  wire [7:0]  m_axi_arlen;
  wire [2:0]  m_axi_arsize;
  wire [1:0]  m_axi_arburst;
  wire        m_axi_arlock;
  wire [3:0]  m_axi_arcache;
  wire [2:0]  m_axi_arprot;
  wire [3:0]  m_axi_arregion;
  wire [3:0]  m_axi_arqos;
  wire        m_axi_arvalid;
  reg         m_axi_arready = 1;

  reg [255:0] m_axi_rdata = 0;
  reg [1:0]   m_axi_rresp = 0;
  reg         m_axi_rlast = 0;
  reg         m_axi_rvalid = 0;
  wire        m_axi_rready;

  // DUT instance
  axi_clock_converter_0 dut (
    .s_axi_aclk, .s_axi_aresetn, .s_axi_awaddr, .s_axi_awlen,
    .s_axi_awsize, .s_axi_awburst, .s_axi_awlock, .s_axi_awcache,
    .s_axi_awprot, .s_axi_awregion, .s_axi_awqos, .s_axi_awvalid,
    .s_axi_awready, .s_axi_wdata, .s_axi_wstrb, .s_axi_wlast,
    .s_axi_wvalid, .s_axi_wready, .s_axi_bresp, .s_axi_bvalid,
    .s_axi_bready, .s_axi_araddr, .s_axi_arlen, .s_axi_arsize,
    .s_axi_arburst, .s_axi_arlock, .s_axi_arcache, .s_axi_arprot,
    .s_axi_arregion, .s_axi_arqos, .s_axi_arvalid, .s_axi_arready,
    .s_axi_rdata, .s_axi_rresp, .s_axi_rlast, .s_axi_rvalid, .s_axi_rready,
    .m_axi_aclk, .m_axi_aresetn, .m_axi_awaddr, .m_axi_awlen,
    .m_axi_awsize, .m_axi_awburst, .m_axi_awlock, .m_axi_awcache,
    .m_axi_awprot, .m_axi_awregion, .m_axi_awqos, .m_axi_awvalid,
    .m_axi_awready, .m_axi_wdata, .m_axi_wstrb, .m_axi_wlast,
    .m_axi_wvalid, .m_axi_wready, .m_axi_bresp, .m_axi_bvalid,
    .m_axi_bready, .m_axi_araddr, .m_axi_arlen, .m_axi_arsize,
    .m_axi_arburst, .m_axi_arlock, .m_axi_arcache, .m_axi_arprot,
    .m_axi_arregion, .m_axi_arqos, .m_axi_arvalid, .m_axi_arready,
    .m_axi_rdata, .m_axi_rresp, .m_axi_rlast, .m_axi_rvalid, .m_axi_rready
  );

  initial begin
    // Reset sequence
    s_axi_aresetn = 1; m_axi_aresetn = 1; 
    #1000 s_axi_aresetn = 0; m_axi_aresetn = 0;
    #1000 s_axi_aresetn = 1; m_axi_aresetn = 1;

    #2000;
    $finish;
  end
endmodule
