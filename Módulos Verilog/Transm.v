module Transm(
		input p_clock,
		input [2:0] led,
		input tx,
		output reg [1:0] col
    );
	 
	 parameter BLANCO=0, ROJO=1, VERDE=2, AZUL=3;
	 
	 always @(posedge p_clock)
    begin
	 if(tx)
	 begin
	 
	 if(led[0]==1 && led[1]==1 && led[2]==1)
	 begin
	 col = BLANCO;
	 end
	 
	 if(led[0]==0 && led[1]==0 && led[2]==1)
	 begin
	 col = ROJO;
	 end
	 
	 if(led[0]==0 && led[1]==1 && led[2]==0)
	 begin
	 col = VERDE;
	 end
	 
	 if(led[0]==1 && led[1]==0 && led[2]==0)
	 begin
	 col = AZUL;
	 end
	 
	 end
	 end


endmodule
