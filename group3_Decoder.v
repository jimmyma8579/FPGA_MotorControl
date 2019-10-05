
module group3_Decoder(clk_48,Hall_A, Hall_B,dir, pos,cyc,Vel,reset_n);

input  clk_48; 
input  Hall_A ;
input  Hall_B ;
input  reset_n;

output reg  dir  ;
output reg [11:0] pos;
output reg [3:0] cyc  ;
output reg [11:0] Vel ;

reg [19:0] timercounter ;
reg [11:0] Velcount ;
reg Hall_Adelayed;
reg Hall_Bdelayed;
parameter time_interval = 2500 ;

//always @(posedge clk_48) Hall_Adelayed <= Hall_A ;
//always @(posedge clk_48) Hall_Bdelayed <= Hall_B;
//wire count_enable = Hall_A  ^ Hall_Adelayed ^ Hall_B ^ Hall_Bdelayed;
//wire count_direction = Hall_A  ^Hall_Bdelayed;

wire add = (~Hall_A) & (Hall_B) & (~Hall_Adelayed) & (~Hall_Bdelayed) |(Hall_A) & (Hall_B) & (~Hall_Adelayed) & (Hall_Bdelayed)|(Hall_A) & (~Hall_B) & (Hall_Adelayed) & (Hall_Bdelayed)|(~Hall_A) & (~Hall_B) & (Hall_Adelayed) & (~Hall_Bdelayed);
wire minus =(Hall_A) & (~Hall_B) & (~Hall_Adelayed) & (~Hall_Bdelayed)|(~Hall_A) & (~Hall_B) & (~Hall_Adelayed) & (Hall_Bdelayed)|(~Hall_A) & (Hall_B) & (Hall_Adelayed) & (Hall_Bdelayed)|(Hall_A) & (Hall_B) & (Hall_Adelayed) & (~Hall_Bdelayed);
wire zero = (~Hall_A) & (~Hall_B) & (~Hall_Adelayed) & (~Hall_Bdelayed)|(~Hall_A) & (Hall_B) & (~Hall_Adelayed) & (Hall_Bdelayed)|(Hall_A) & (Hall_B) & (Hall_Adelayed) & (Hall_Bdelayed)|(Hall_A) & (~Hall_B) & (Hall_Adelayed) & (~Hall_Bdelayed);

always @(posedge clk_48)
begin
if(reset_n==1) 
 begin
  timercounter <= timercounter +1  ;
  Hall_Adelayed <= Hall_A ;
  Hall_Bdelayed <= Hall_B ;
  if(pos==0 && minus == 1) 
  begin
   pos <=  347 ;   
   cyc <= cyc -1 ;
  end
  
  else if(add)
  begin
  dir <= 1 ; 
  pos <= pos+1;
  Velcount <= Velcount +1;
  end 
  
  else if(minus && pos>0)
  begin 
  dir <= 0;
  pos <= pos-1;
  Velcount <= Velcount-1;
  end
  
  else if(zero)
  begin
  pos <= pos;
  Velcount <= Velcount ;
  end
  
  if(pos>347) 
  begin
   cyc <= cyc +1 ;
   pos <= pos -348 ;
  end
  if(timercounter> time_interval)
  begin
  Vel <= Velcount ;
  Velcount <= 0 ;
  timercounter <= 0 ;
  end
	
end  
else
begin 
pos <= 0 ;
cyc <= 0 ;
dir <= 0 ;
timercounter <= 0 ;
Vel <= 0 ;

end
end
endmodule


