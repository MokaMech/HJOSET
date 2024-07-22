function out1 = L_ASIS_Position(in1,in2,in3)
%L_ASIS_Position
%    OUT1 = L_ASIS_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    02-Apr-2024 17:47:26

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
mt1 = [R1cut1_3.*(-1.174358836006921e-1)+p1cut1+R1cut1_1.*t2.*8.232537237483792e-2-R1cut1_1.*t3.*7.841627306878524e-2+R1cut1_2.*t2.*7.841627306878524e-2+R1cut1_2.*t3.*8.232537237483792e-2];
mt2 = [R1cut2_3.*(-1.174358836006921e-1)+p1cut2+R1cut2_1.*t2.*8.232537237483792e-2-R1cut2_1.*t3.*7.841627306878524e-2+R1cut2_2.*t2.*7.841627306878524e-2+R1cut2_2.*t3.*8.232537237483792e-2];
mt3 = [R1cut3_3.*(-1.174358836006921e-1)+p1cut3+R1cut3_1.*t2.*8.232537237483792e-2-R1cut3_1.*t3.*7.841627306878524e-2+R1cut3_2.*t2.*7.841627306878524e-2+R1cut3_2.*t3.*8.232537237483792e-2];
out1 = [mt1;mt2;mt3];
end
