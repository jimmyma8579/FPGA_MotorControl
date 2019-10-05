module Bin2BCD(Bin,ones,tens,huns,thous);

input [11:0] Bin;
output reg[3:0] ones;
output reg[3:0] tens;
output reg[3:0] huns;
output reg[3:0] thous;

reg[11:0] temp;
reg[15:0] BCD;
reg[3:0] i;

always @ (Bin)
	begin
		BCD = 16'b0000_0000_0000_0000;
		temp = Bin;
		
		for(i = 0; i <=11 ; i = i + 4'b1)
			begin
				if(BCD[3:0] > 4)
					BCD[3:0] = BCD[3:0] + 4'd3;
				if(BCD[7:4] > 4)
					BCD[7:4] = BCD[7:4] + 4'd3;
				if(BCD[11:8] > 4)
					BCD[11:8] = BCD[11:8] + 4'd3;
				if(BCD[15:12] > 4)
					BCD[15:12] = BCD[15:12] + 4'd3;
					
				BCD = {BCD[14:0],temp[11]};
				temp = {temp[10:0],1'b0};
			end
		ones <= BCD[3:0];
		tens <= BCD[7:4];
		huns <= BCD[11:8];
		thous <= BCD[15:12];
	end

endmodule
	
		