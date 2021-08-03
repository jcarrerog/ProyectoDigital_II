module config_reg(
    input clk,
    input [7:0] addr,
    output reg [15:0] dout
    );
	 
	 //FFFF is el fin de los reg, FFF0 el delay
    always @(posedge clk) begin
    case(addr) 
	 
	 0:  dout <= 16'h12_80; //reset
    1:  dout <= 16'hFF_F0; //delay
    2:  dout <= 16'h12_04; // COM7,     Pone la salida de color RGB
    3:  dout <= 16'h11_80; // CLKRC     PLL interno coincide con el reloj de entrada
    4:  dout <= 16'h0C_00; // COM3,     configuracin por defecto
    5:  dout <= 16'h3E_00; // COM14,    sin escala, pclock normal
	 
	 6:  dout <= 16'h04_00; // COM1,     desactivar CCIR656
    7:  dout <= 16'h40_d0; //COM15,     RGB565, rango de salida completo 
    8:  dout <= 16'h3a_04; //TSLB       establece la secuencia de datos de salida correcta
    9:  dout <= 16'h14_18; //COM9       MAX AGC valor x4
	 
    10: dout <= 16'h4F_B3; //MTX1       todos estos son coeficientes de matriz color
	 11: dout <= 16'h50_B3; //MTX2
    12: dout <= 16'h51_00; //MTX3
    13: dout <= 16'h52_3d; //MTX4
    14: dout <= 16'h53_A7; //MTX5
    15: dout <= 16'h54_E4; //MTX6
	 16: dout <= 16'h58_9E; //MTXS
	 
    17: dout <= 16'h3D_C0; //COM13      establece la habilitacion de gamma
    18: dout <= 16'h17_14; //HSTART HREF    start high 8 bits
    19: dout <= 16'h18_02; //HSTOP HREF     stop high 8 bits
    20: dout <= 16'h32_80; //HREF       edge offset
	  21: dout <= 16'h19_03; //VSTART     start high 8 bits
    22: dout <= 16'h1A_7B; //VSTOP      stop high 8 bits
    23: dout <= 16'h03_0A; //VREF       vsync edge offset
	 
    24: dout <= 16'h0F_41; //COM6       resetea tiempos
    25: dout <= 16'h1E_00; //MVFP       deshabilitar espejo / voltear // podra tener un valor mgico de 03
	 26: dout <= 16'h33_0B; //CHLF       valor mgico de internet
    27: dout <= 16'h3C_78; //COM12      no HREF cuando VSYNC low
    28: dout <= 16'h69_00; //GFIX       arregla el control de ganancia
    29: dout <= 16'h74_00; //REG74      control de ganancia digital
    30: dout <= 16'hB0_84; //RSVD       valor magico de Internet, requerido para un buen color
	 31: dout <= 16'hB1_0c; //ABLC1
    32: dout <= 16'hB2_0e; //RSVD       mas valores magicos de internet
    33: dout <= 16'hB3_80; //THL_ST
	 
    //comienza numeros misteriosos de escala
    34: dout <= 16'h70_3a;
    35: dout <= 16'h71_35;
	 36: dout <= 16'h72_11;
    37: dout <= 16'h73_f0;
    38: dout <= 16'ha2_02;
	 
    //valores de la curva de gamma
    39: dout <= 16'h7a_20;
    40: dout <= 16'h7b_10;
	 41: dout <= 16'h7c_1e;
    42: dout <= 16'h7d_35;
    43: dout <= 16'h7e_5a;
    44: dout <= 16'h7f_69;
    45: dout <= 16'h80_76;
	 46: dout <= 16'h81_80;
    47: dout <= 16'h82_88;
    48: dout <= 16'h83_8f;
    49: dout <= 16'h84_96;
    50: dout <= 16'h85_a3;
	 51: dout <= 16'h86_af;
    52: dout <= 16'h87_c4;
    53: dout <= 16'h88_d7;
    54: dout <= 16'h89_e8;
	 
    //AGC and AEC
    54: dout <= 16'h13_e0; //COM8, desactiva AGC / AEC
    55: dout <= 16'h00_00; //pone registro de ganancia de 0 para AGC
	 56: dout <= 16'h10_00; //pone registro ARCJ a 0
    57: dout <= 16'h0d_40; //bit mgico reservado para COM4
    58: dout <= 16'h14_18; //COM9, 4x ganancia + bit mgico
    59: dout <= 16'ha5_05; // BD50MAX
    60: dout <= 16'hab_07; //DB60MAX
	 61: dout <= 16'h24_95; //AGC upper limite
    62: dout <= 16'h25_33; //AGC lower limite
    63: dout <= 16'h26_e3; //AGC/AEC regin de operacin de modo rpido
    64: dout <= 16'h9f_78; //HAECC1
    65: dout <= 16'ha0_68; //HAECC2
	 66: dout <= 16'ha1_03; //magic
    67: dout <= 16'ha6_d8; //HAECC3
    68: dout <= 16'ha7_d8; //HAECC4
    69: dout <= 16'ha8_f0; //HAECC5
    70: dout <= 16'ha9_90; //HAECC6
	 71: dout <= 16'haa_94; //HAECC7
    72: dout <= 16'h13_e5; //COM8, activa AGC / AEC
    default: dout <= 16'hFF_FF;         //marca el fin de los registros
    endcase
    
    end


endmodule
