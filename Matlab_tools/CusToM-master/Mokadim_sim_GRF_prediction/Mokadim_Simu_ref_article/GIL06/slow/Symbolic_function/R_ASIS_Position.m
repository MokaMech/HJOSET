function out1 = R_ASIS_Position(in1,in2,in3)
%R_ASIS_Position
%    OUT1 = R_ASIS_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    31-Mar-2024 19:44:12

R1cut1_1 = in3(1);
R1cut1_2 = in3(4);
R1cut1_3 = in3(7);
R1cut2_1 = in3(2);
R1cut2_2 = in3(5);
R1cut2_3 = in3(8);
R1cut3_1 = in3(3);
R1cut3_2 = in3(6);
R1cut3_3 = in3(9);
p1cut1 = in2(1);
p1cut2 = in2(2);
p1cut3 = in2(3);
q1 = in1(1,:);
t2 = cos(q1);
t3 = sin(q1);
mt1 = [R1cut1_3.*1.282731020068064e-1+p1cut1+R1cut1_1.*t2.*5.39341253618712e-2-R1cut1_1.*t3.*6.236371376487338e-2+R1cut1_2.*t2.*6.236371376487338e-2+R1cut1_2.*t3.*5.39341253618712e-2];
mt2 = [R1cut2_3.*1.282731020068064e-1+p1cut2+R1cut2_1.*t2.*5.39341253618712e-2-R1cut2_1.*t3.*6.236371376487338e-2+R1cut2_2.*t2.*6.236371376487338e-2+R1cut2_2.*t3.*5.39341253618712e-2];
mt3 = [R1cut3_3.*1.282731020068064e-1+p1cut3+R1cut3_1.*t2.*5.39341253618712e-2-R1cut3_1.*t3.*6.236371376487338e-2+R1cut3_2.*t2.*6.236371376487338e-2+R1cut3_2.*t3.*5.39341253618712e-2];
out1 = [mt1;mt2;mt3];
end
