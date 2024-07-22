function out1 = L_Shank_Upper_Position(in1,in2,in3)
%L_Shank_Upper_Position
%    OUT1 = L_Shank_Upper_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    30-Mar-2024 20:23:39

R2cut1_1 = in3(10);
R2cut1_2 = in3(13);
R2cut1_3 = in3(16);
R2cut2_1 = in3(11);
R2cut2_2 = in3(14);
R2cut2_3 = in3(17);
R2cut3_1 = in3(12);
R2cut3_2 = in3(15);
R2cut3_3 = in3(18);
p2cut1 = in2(4);
p2cut2 = in2(5);
p2cut3 = in2(6);
q19 = in1(15,:);
t2 = cos(q19);
t3 = sin(q19);
mt1 = [R2cut1_3.*(-5.63360668918344e-2)+p2cut1+R2cut1_1.*t2.*1.18194635800266e-2+R2cut1_1.*t3.*6.616918378278439e-2-R2cut1_2.*t2.*6.616918378278439e-2+R2cut1_2.*t3.*1.18194635800266e-2];
mt2 = [R2cut2_3.*(-5.63360668918344e-2)+p2cut2+R2cut2_1.*t2.*1.18194635800266e-2+R2cut2_1.*t3.*6.616918378278439e-2-R2cut2_2.*t2.*6.616918378278439e-2+R2cut2_2.*t3.*1.18194635800266e-2];
mt3 = [R2cut3_3.*(-5.63360668918344e-2)+p2cut3+R2cut3_1.*t2.*1.18194635800266e-2+R2cut3_1.*t3.*6.616918378278439e-2-R2cut3_2.*t2.*6.616918378278439e-2+R2cut3_2.*t3.*1.18194635800266e-2];
out1 = [mt1;mt2;mt3];
end