module cam_otr(
	 input clk,
	 input p_clock_c,
    input rst_sw,
	 input pwdn_sw,
	 output rst,
	 output pwdn,
	 output reg p_clock,
	 output reg xclk = 1 //25MHz
    );

    reg[3:0] contador = 0; 
	 
 
    always @(posedge clk)
    begin
    contador = contador + 1; 
    if(contador == 5)
    begin
      contador = 0;
      xclk = ~xclk; 
    end
  end
  
	 always @ (clk)
	 begin
	 p_clock = p_clock_c;
	 end
  
  assign rst = (rst_sw) ? 0:1;
  assign pwdn = (pwdn_sw) ? 1:0;
  
  endmodule
