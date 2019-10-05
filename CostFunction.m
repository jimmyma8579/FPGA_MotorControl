%	Final Lab for 10610PME 520300 Digital Control System
%	This is matlab code for calculate the cost for motor control.
%					2017/12/21

disp(' ');disp('      Cost Calculator~~'); disp(' ');
disp('      Please input Basic parameter¡G'); disp(' ');
Control_par = input('What is you Control input for duty ratio 100%?');
Process_time = 16.5;
Data_Num = 600;
dt = Process_time/Data_Num;
Weighting = 10;
Cost_Max = 6000;
Duty = Control / Control_par * 100;
Cost = 0;
for i = 1:Data_Num
    Cost = Cost + ( Weighting * (Error(i)*100/348)^2 + (Duty(i) - 50 )^2 ) *dt;
end

disp('The cost = ');
disp([blanks(4) num2str(Cost)]);

if(Cost <= Cost_Max)
    disp('      PASS!!'); disp(' ');
else
    disp('      Fail QQ'); disp(' ');    
end

subplot(1,2,1)
plot(Error)
title('Error')
subplot(1,2,2)
plot(Duty)
title('Duty ratio')