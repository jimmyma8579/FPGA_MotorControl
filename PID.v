
module PID #(parameter W=11) // bit width – 1
(
output signed [W:0] u_out = 1000, // output
input clk,
input signed [W:0] e_in, // input
input e_sign,
input reset
);

reg signed [W:0] u_prev;
reg signed [W:0] e_prev[1:2];

parameter kp = 11; // change these values to suit your system
parameter ki = 0;
parameter kd = 0;


assign u_out = u_prev + (kp+ki+kd) * e_in + (-kp - 2*ki) * e_prev[1] + kd * e_prev[2];
 
always @ (posedge clk)
	if (reset == 0) begin
		u_prev <= 0;
		e_prev[1] <= 0;
		e_prev[2] <= 0;
	end
	else begin
		e_prev[2] <= e_prev[1];
		e_prev[1] <= e_in;
		u_prev <= u_out;
	end
endmodule 