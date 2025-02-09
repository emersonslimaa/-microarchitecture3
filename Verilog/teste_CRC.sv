`timescale 1ns/1ps
module teste_CRC;

reg [7:0] dado;
reg [7:0] crc;
reg [2:0] count;

wire ck_crc;
wire ck_alarme;
wire [7:0] newcrc;
check_CRC testeCRC(ck_crc, ck_alarme, dado, crc, newcrc);
initial begin
    dado = 8'b00000000;
    crc = 8'b00110111;
    count = 2'b00;
end
 always @(*)
   begin
    while(count<4)begin
      if(count == 2)begin
	dado=8'b00000001;
	crc=8'b00110110;
      end
      $display("%d ITERACAO",count);
      $display("Dado %b",dado);
      $display("CRC %b",crc);
	#200
      if(ck_alarme == 1'b1 && count < 2) begin
	 $display("Alarme OK %b ",ck_alarme);
      end
      else if(count < 2 && ck_alarme != 1'b1) begin
 	 $display("Erro no Alarme %b",ck_alarme);	
      end
       #200
      if(count > 1 && ck_crc == 1'b1)begin
         $display("Sensor OK %b",ck_crc);          
      end
      else if(count > 1 && ck_crc != 1'b1)begin
         $display("Erro no sensor %b",ck_crc);
      end
	#100
      if(count < 1 || count >= 2)begin	
	  crc++;
      end
	#200
      
      count++;
    end
 end
 
 
endmodule
