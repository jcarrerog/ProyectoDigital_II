module Control(
		input clk,
		input start,
		output lect,
		output cam_ot,
		output colr,
		output tx		
    );
	 
	 parameter CAM_OT=0, LECT=1, COLR=2, TX=3;

reg [1:0] status=CAM_OT;
reg lect1;
reg cam_ot1;
reg colr1;
reg tx1;

always @ (posedge clk)
begin

case (status)
CAM_OT: begin 
lect1=0;
cam_ot1=1;
colr1=0;
tx1=0;
if(start)
begin
status=LECT;
end
end

LECT: begin
lect1=1;
cam_ot1=0;
colr1=0;
tx1=0;
status=COLR;

end

COLR: begin
lect1=0;
cam_ot1=0;
colr1=1;
tx1=0;
status=TX;

end

TX: begin
lect1=0;
cam_ot1=0;
colr1=0;
tx1=1;
status=CAM_OT;

end

endcase

end

assign lect = lect1;
assign cam_ot = cam_ot1;
assign colr = colr1;
assign tx = tx1;

endmodule
