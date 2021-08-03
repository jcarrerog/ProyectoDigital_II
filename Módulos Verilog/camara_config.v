module camara_config
#(
    parameter clk_freq = 25000000
)
(
    input clk,
    input SCCB_ready,
    input [15:0] reg_data,
    input start,
    output reg [7:0] reg_addr, //Direccin
    output reg done,
    output reg [7:0] SCCB_addr,
    output reg [7:0] SCCB_reg,
    output reg SCCB_start
    );
	 
	 initial begin
        reg_addr = 0;
        done = 0;
        SCCB_addr = 0;
        SCCB_reg = 0;
        SCCB_start = 0;
    end
	 
	 parameter Inact = 0, Env_Comd = 1, Done = 2, Timer = 3; // Inactivo, Enviar comando
    
    reg [2:0] State = Inact;
    reg [2:0] Return_state;
    reg [31:0] cont = 0; // Contador
	 
	 always@(posedge clk) begin
    
        case(State)
            
            Inact: begin 
                State <= start ? Env_Comd : Inact;
                reg_addr <= 0;
                done <= start ? 0 : done;
            end
				
			 Env_Comd: begin 
                case(reg_data)
                    16'hFFFF: begin // Fin de los registros
                        State <= Done;
                    end
                    
                    16'hFFF0: begin // Estado de delay 
                        cont <= (clk_freq/100); //10 ms de delay
                        State <= Timer;
                        Return_state <= Env_Comd;
                        reg_addr <= reg_addr + 1;
                    end
						  
						  default: begin // Comandos de registro normales
                        if (SCCB_ready) begin
                            State <= Timer;
                            Return_state <= Env_Comd;
                            cont <= 0; 
                            reg_addr <= reg_addr + 1;
									 
									 SCCB_addr <= reg_data[15:8];
                            SCCB_reg <= reg_data[7:0];
                            SCCB_start <= 1;
                        end
                    end
                endcase
            end
				
				Done: begin  
                State <= Inact;
                done <= 1;
            end
                           
                
            Timer: begin //Cuenta regresiva y pasa al siguiente estado
                State <= (cont == 0) ? Return_state : Timer;
                cont <= (cont==0) ? 0 : cont - 1;
                SCCB_start <= 0;
            end
        endcase
    end


endmodule
