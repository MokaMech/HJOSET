function out1 = R_Shank_Rear_Position(in1,in2,in3)
%R_Shank_Rear_Position
%    OUT1 = R_Shank_Rear_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    02-Apr-2024 17:47:27

R3cut1_1 = in3(19);
R3cut1_2 = in3(22);
R3cut1_3 = in3(25);
R3cut2_1 = in3(20);
R3cut2_2 = in3(23);
R3cut2_3 = in3(26);
R3cut3_1 = in3(21);
R3cut3_2 = in3(24);
R3cut3_3 = in3(27);
p3cut1 = in2(7);
p3cut2 = in2(8);
p3cut3 = in2(9);
q10 = in1(8,:);
t2 = cos(q10);
t3 = sin(q10);
mt1 = [R3cut1_3.*6.49980800401012e-2+p3cut1-R3cut1_1.*t2.*8.348120954854293e-4+R3cut1_1.*t3.*1.614741295363689e-1-R3cut1_2.*t2.*1.614741295363689e-1-R3cut1_2.*t3.*8.348120954854293e-4];
mt2 = [R3cut2_3.*6.49980800401012e-2+p3cut2-R3cut2_1.*t2.*8.348120954854293e-4+R3cut2_1.*t3.*1.614741295363689e-1-R3cut2_2.*t2.*1.614741295363689e-1-R3cut2_2.*t3.*8.348120954854293e-4];
mt3 = [R3cut3_3.*6.49980800401012e-2+p3cut3-R3cut3_1.*t2.*8.348120954854293e-4+R3cut3_1.*t3.*1.614741295363689e-1-R3cut3_2.*t2.*1.614741295363689e-1-R3cut3_2.*t3.*8.348120954854293e-4];
out1 = [mt1;mt2;mt3];
end
