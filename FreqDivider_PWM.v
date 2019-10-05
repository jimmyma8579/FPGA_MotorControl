

module FreqDivider_PWM(clk, duty_ratio,PWM_out, in_PWM_out, control);
parameter divisor = 2000;
 
input clk;
input signed [11:0] duty_ratio;
output PWM_out;
output in_PWM_out;
output [11:0] control;

reg signed [11:0] divisor2;
reg[11:0] cnt1;
reg cnt2 = 0;
wire EN;
wire compare1,compare2;

always @ (posedge clk)
begin
	
 divisor2 = duty_ratio;
  
	if( divisor2 > 0)
	begin
		divisor2 = 1330 + divisor2 ;
	
		if (divisor2 > 2000)
		begin
			divisor2 = 2000 ;	
	   end
	end
	
	else if(divisor2 < 0)
	begin
		divisor2 = 780 + divisor2;
	
		if (divisor2 < 0)
		begin
			divisor2 = 0 ;
		end	
	end
	else
		divisor2 = 1000;
		
	if(cnt1 == divisor)
		cnt1 <= 1;
	else
		  cnt1 <= cnt1 + 1;
end

assign control = divisor2;

assign compare1 = (cnt1 == divisor) ? 1:0;
assign compare2 = (cnt1 == divisor2) ? 1:0;
assign EN = compare1 || compare2;

always @ (posedge clk)
	begin
		
	 if(compare1 == 1)
			cnt2 <= 1;//!cnt2;
	 else if (compare2 == 1)
			cnt2 <= 0;//cnt2;
	end

assign PWM_out = cnt2;
assign in_PWM_out = !cnt2;

endmodule 

