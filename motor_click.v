
module motor_click
(
input  clk_48    , 
input  reset_n   ,
input  EN_180_90 ,        //  1 for 90 , 0 for 180
input  command   ,
input   [11:0] pos ,

output reg [11:0] errorabs,
output reg signed [11:0] error,
output reg errorsign      // 1 for - , 0 for + 
);

reg   [11:0] next_errorabs ;
reg    next_errorsign ;
reg  signed [11:0] next_error ;
reg   [11:0] pos_reg ; 

always @(posedge clk_48 or negedge reset_n)

begin
 
    if (reset_n == 0) 
	 begin
	 	 errorabs <= 0 ;
		 errorsign <= 0 ;
		 error <=  0 ;
		 pos_reg <= 0 ;
	 end
	 
    else	 
	 begin
 		 errorabs  <= next_errorabs ;
	    pos_reg  <= pos ;
       error  <= next_error ;  
		 errorsign  <= next_errorsign ;
	 end		
end



always @(*)
begin 
   next_errorabs = errorabs;
   next_error  = error ;
	next_errorsign  = errorsign ;
	
	if (EN_180_90 ==  0)  // 0 for 180  
	begin
		next_error = 174 - pos_reg ;
		next_errorsign = 0 ;
	
		if(next_error < 0)
		begin
			next_errorabs =  -next_error ;
			next_errorsign = 1 ;
		end
		else	begin
			next_errorabs = next_error ;
			next_errorsign = 0 ;
		end
		
	end
	
	if (EN_180_90 ==  1)  // 1 for 90  
	begin
		next_error = 87 - pos_reg ;
		
		
		if(next_error < 0)
		begin
			next_errorabs =  -next_error ;
			next_errorsign = 1 ;
		end
		else	begin
			next_errorabs = next_error ;
			next_errorsign = 0 ;
		end
	
	end
	
end 



endmodule


