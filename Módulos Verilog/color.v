module color(
	 input p_clock,
	 input [15:0] pixel_data,
	 input colr,
	 output [4:0] R,
	 output [5:0] G,
	 output [4:0] B,
	 output [2:0] led
    );
	 
	 reg [2:0] y;
	 
	 always @(posedge p_clock)
    begin
	 if(colr)
	 begin
	 
	 if(R>17 && G<20 && B<11)
	 begin
	 y[2] = 1; // Color Rojo
	 y[1] = 0;
	 y[0] = 0;
	 end
	 
    if(R<11 && G>28 && B<11)
	 begin
	 y[1] = 1; // Color Verde
	 y[2] = 0;
	 y[0] = 0;
	 end
	 
    if(R<11 && G<20 && B>17)
	 begin
	 y[0] = 1; // Color Azul
	 y[1] = 0;
	 y[2] = 0;
	 end
	 
	 if(R<11 && G<20 && B>17) //Caso Default, color blanco
	 begin
	 y[0] = 1; // Color Azul
	 y[1] = 1; // Color Verde
	 y[2] = 1; // Color Rojo
	 end
	 end
	 end
	 
	 assign R = pixel_data[15:11];
	 assign G = pixel_data[10:5];
	 assign B = pixel_data[3:0];
	 assign led[0] = y[0];
    assign led[1] = y[1];
    assign led[2] = y[2];
    
endmodule
