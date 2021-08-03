module camara_lect(
   input p_clock,
	input vsync,
	input href,
	input [7:0] d,
	input lect,
	output reg [15:0] pixel_data =0,
	output reg pixel_valid = 0,
	output reg frame_done = 0
    );
	 
	 reg [1:0] FSM_state = 0;
    reg pixel_half = 0;
	 
	 parameter WAIT_FRAME_START = 0, ROW_CAPTURE = 1;
	 
	 always@(posedge p_clock)
	begin 
	
	if(lect)
	begin
	
	case(FSM_state)
	
	WAIT_FRAME_START: begin //Espera por vsync
	   FSM_state <= (!vsync) ? ROW_CAPTURE : WAIT_FRAME_START;
	   frame_done <= 0;
	   pixel_half <= 0;
	end
	
	ROW_CAPTURE: begin 
	   FSM_state <= vsync ? WAIT_FRAME_START : ROW_CAPTURE;
	   frame_done <= vsync ? 1 : 0;
	   pixel_valid <= (href && pixel_half) ? 1 : 0; 
	   if (href) begin
	       pixel_half <= ~ pixel_half;
	       if (pixel_half) pixel_data[7:0] <= d;
	       else pixel_data[15:8] <= d;
	   end
	end
	
	
	endcase
	end
	end

endmodule
