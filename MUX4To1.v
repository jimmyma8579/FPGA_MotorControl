module MUX4To1(clk,ones,tens,huns,thous,OUT,EN);

input clk ;
input [7:0] ones;
input [7:0] tens;
input [7:0] huns;
input [7:0] thous;
output reg[7:0] OUT;
output reg[3:0] EN;


initial EN = 4'b0111;
initial OUT=0;

always @ (negedge clk)
begin
  
  if(EN == 4'b0111)
     begin
      OUT = tens ;
	   EN = 4'b1011 ;
     end
	  
  else if(EN == 4'b1011)
    begin
     OUT = huns ;
	  EN = 4'b1101 ;
    end 
   else if(EN == 4'b1101)
    begin
     OUT = thous ;
	  EN = 4'b1110 ;
    end 
	else if(EN == 4'b1110)
    begin
     OUT = ones ;
	  EN = 4'b0111 ;
    end 

end

endmodule
