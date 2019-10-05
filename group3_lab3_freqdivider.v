/*
	This is a sample code of Frequency Divider for 10610PME 520300 Digital Control System.
*/

module group3_lab3_freqdivider(IN,OUT);

parameter divisor =200;  // out_freq = IN_freq / divisor
parameter divisor2=100; //  output duty ratio = divisor2 / divisor * 100 % 


input IN;
output OUT;



reg[7:0] cnt1;
reg cnt2;
wire EN;
wire compare1,compare2;

always @ (posedge IN )
	begin
		
	 if(cnt1 == divisor)
			cnt1 <= 1;
		else
			cnt1 <= cnt1 + 1;
	end

assign compare1 = (cnt1 == divisor) ? 1:0;
assign compare2 = (cnt1 == divisor2) ? 1:0;
assign EN = compare1 || compare2;

always @ (posedge IN )
	begin
		
	 if(EN == 1)
			cnt2 <= !cnt2;
		else
			cnt2 <= cnt2;
	end

assign OUT = cnt2;

endmodule


