function out1 = L_Thigh_Upper_Position(in1,in2,in3)
%L_Thigh_Upper_Position
%    OUT1 = L_Thigh_Upper_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    30-Mar-2024 20:35:17

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
q14 = in1(12,:);
q15 = in1(13,:);
q16 = in1(14,:);
t2 = cos(q1);
t3 = cos(q14);
t4 = cos(q15);
t5 = cos(q16);
t6 = sin(q1);
t7 = sin(q14);
t8 = sin(q15);
t9 = sin(q16);
t10 = R1cut1_1.*t2;
t11 = R1cut1_2.*t2;
t12 = R1cut2_1.*t2;
t13 = R1cut2_2.*t2;
t14 = R1cut1_3.*t4;
t15 = R1cut3_1.*t2;
t16 = R1cut3_2.*t2;
t17 = R1cut2_3.*t4;
t18 = R1cut3_3.*t4;
t19 = R1cut1_1.*t6;
t20 = R1cut1_2.*t6;
t21 = R1cut2_1.*t6;
t22 = R1cut2_2.*t6;
t23 = R1cut3_1.*t6;
t24 = R1cut3_2.*t6;
t28 = -t19;
t29 = -t21;
t30 = -t23;
t31 = t10+t20;
t32 = t12+t22;
t33 = t15+t24;
t34 = t11+t28;
t35 = t13+t29;
t36 = t16+t30;
t37 = t3.*t31;
t38 = t3.*t32;
t39 = t3.*t33;
t40 = t7.*t31;
t41 = t7.*t32;
t42 = t7.*t33;
t43 = t3.*t34;
t44 = t3.*t35;
t45 = t3.*t36;
t46 = t7.*t34;
t48 = t7.*t35;
t50 = t7.*t36;
t52 = t37+t46;
t53 = t38+t48;
t54 = t39+t50;
et1 = R1cut1_3.*(-9.398170577147139e-2)+p1cut1-t11.*7.439749402987136e-2+t19.*7.439749402987136e-2-t5.*(t14+t8.*(t40-t43)).*7.331454067048712e-2;
et2 = t9.*(t14+t8.*(t40-t43)).*(-4.919391042175066e-2)-R1cut1_3.*t8.*1.633669629088402e-1+t5.*t52.*4.919391042175066e-2-t9.*t52.*7.331454067048712e-2;
et3 = t4.*(t40-t43).*1.633669629088402e-1;
et4 = R1cut2_3.*(-9.398170577147139e-2)+p1cut2-t13.*7.439749402987136e-2+t21.*7.439749402987136e-2-t5.*(t17+t8.*(t41-t44)).*7.331454067048712e-2;
et5 = t9.*(t17+t8.*(t41-t44)).*(-4.919391042175066e-2)-R1cut2_3.*t8.*1.633669629088402e-1+t5.*t53.*4.919391042175066e-2-t9.*t53.*7.331454067048712e-2;
et6 = t4.*(t41-t44).*1.633669629088402e-1;
et7 = R1cut3_3.*(-9.398170577147139e-2)+p1cut3-t16.*7.439749402987136e-2+t23.*7.439749402987136e-2-t5.*(t18+t8.*(t42-t45)).*7.331454067048712e-2;
et8 = t9.*(t18+t8.*(t42-t45)).*(-4.919391042175066e-2)-R1cut3_3.*t8.*1.633669629088402e-1+t5.*t54.*4.919391042175066e-2-t9.*t54.*7.331454067048712e-2;
et9 = t4.*(t42-t45).*1.633669629088402e-1;
out1 = [et1+et2+et3;et4+et5+et6;et7+et8+et9];
end