module main #(
    parameter clk_freq=25000000
    )
    (
    input wire clk,
    input wire start,
	 input wire p_clock_c,
	 input wire vsync,
	 input wire href,
	 input wire [7:0]d,
	 input wire rst_sw,
	 input wire pwdn_sw,
    output wire sioc,
    output wire siod,
	 output wire rst,
	 output wire pwdn,
	 output wire xclk,
    output wire done,
	    output wire [3:0]led,
	    output wire [1:0]col
    ); 
	 
	 wire p_clock;
	 wire [7:0] reg_addr;
    wire [15:0] reg_dout;
    wire [7:0] SCCB_addr;
    wire [7:0] SCCB_reg;
    wire SCCB_start;
    wire SCCB_ready;
    wire SCCB_SIOC_oe;
    wire SCCB_SIOD_oe;
	 wire pixel_valid;
	 wire [15:0] pixel_data;
	 wire [4:0] R;
	 wire [5:0] G;
	 wire [4:0] B;
	 wire lect;
	 wire cam_ot;
	 wire colr;
	 wire tx;
	 
	 assign sioc = SCCB_SIOC_oe ? 1'b0 : 1'bZ;
    assign siod = SCCB_SIOD_oe ? 1'b0 : 1'bZ;
	 
	 config_reg U1(
        .clk(clk),
        .addr(reg_addr),
        .dout(reg_dout)
        );
		  
		  
		  camara_config #(.clk_freq(clk_freq)) U2(
        .clk(clk),
        .SCCB_ready(SCCB_ready),
        .reg_data(reg_dout),
        .start(start),
        .reg_addr(reg_addr),
        .done(done),
        .SCCB_addr(SCCB_addr),
        .SCCB_reg(SCCB_reg),
        .SCCB_start(SCCB_start)
        );
		  
		  SCCB #( .CLK_FREQ(clk_freq)) U3(
        .clk(clk),
        .start(SCCB_start),
        .address(SCCB_addr),
        .data(SCCB_reg),
        .ready(SCCB_ready),
        .SIOC_oe(SCCB_SIOC_oe),
        .SIOD_oe(SCCB_SIOD_oe)
        );
		  
	 camara_lect U4 (
	.p_clock(p_clock),
	.vsync(vsyinc),
	.href(href),
	.d(d),
        .lect(lect),
        .pixel_data(pixel_data),
        .pixel_valid(pixel_valid),
	.frame_done(led[3])	  
		  );
		  
	      cam_otr U5 (
	     .clk(clk),
	     .p_clock_c(p_clock_c),
       	     .rst_sw(rst_sw),
	     .pwdn_sw(pwdn_sw),
	     .rst(rst),
	     .pwdn(pwdn),
	     .cam_ot(cam_ot),
             .p_clock(p_clock),
	     .xclk(xclk)
		  );
		  
		  color U6 (
		  .p_clock(p_clock),
	     .pixel_data(pixel_data),
	     .colr(colr),
	     .R(R),
	     .G(G),
	     .B(B),
	     .led(led[2:0])
		  );
	
	         Transm U7 (
		  .p_clock(p_clock),
	     .led(led[2:0]),
	     .tx(tx),
		  .col(col[1:0])  
		  );
		  
		  Control U8 (
		  .clk(clk),
		  .start(start),
		  .lect(lect),
		  .cam_ot(cam_ot),
		  .colr(colr),
		  .tx(tx)		  
		  );



endmodule
