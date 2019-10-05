module BCDTo7LED(BCDin,LEDout);



input [3:0] BCDin;
output reg[7:0] LEDout;


	always @ (BCDin)
   begin
	   if(BCDin == 0) 
		LEDout <= 8'b00111111 ;
		else if(BCDin == 1)
      LEDout <= 8'b00000110 ; 		
      else if(BCDin == 2)
      LEDout <= 8'b01011011 ;
		else if(BCDin == 3)
      LEDout <= 8'b01001111 ;
		else if(BCDin == 4)
      LEDout <= 8'b01100110 ;
	   else if(BCDin == 5)
      LEDout <= 8'b01101101 ;
		else if(BCDin == 6)
      LEDout <= 8'b01111101 ;
		else if(BCDin == 7)
      LEDout <= 8'b00000111 ;
		else if(BCDin == 8)
      LEDout <= 8'b01111111 ;
		else if(BCDin == 9)
      LEDout <= 8'b01101111 ;
	end
	
	
endmodule
