function out1 = Sternum_Position(in1,in2,in3)
%Sternum_Position
%    OUT1 = Sternum_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    30-Mar-2024 21:23:13

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
q2 = in1(2,:);
q3 = in1(3,:);
q4 = in1(4,:);
t2 = cos(q1);
t3 = cos(q2);
t4 = cos(q3);
t5 = cos(q4);
t6 = sin(q1);
t7 = sin(q2);
t8 = sin(q3);
t9 = sin(q4);
t10 = R1cut1_1.*t2;
t11 = R1cut1_2.*t2;
t12 = R1cut1_3.*t4;
t13 = R1cut2_1.*t2;
t14 = R1cut2_2.*t2;
t15 = R1cut2_3.*t4;
t16 = R1cut3_1.*t2;
t17 = R1cut3_2.*t2;
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
t32 = t13+t22;
t33 = t16+t24;
t34 = t11+t28;
t35 = t14+t29;
t36 = t17+t30;
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
et1 = p1cut1-t10.*3.421289764284745e-2+t11.*9.294503859640228e-2-t19.*9.294503859640228e-2-t20.*3.421289764284745e-2;
et2 = t5.*(t12+t8.*(t40-t43)).*(-2.593649734646368e-3)-t9.*(t12+t8.*(t40-t43)).*5.068505235394203e-2+R1cut1_3.*t8.*2.938539014000548e-1+t5.*t52.*5.068505235394203e-2;
et3 = t9.*t52.*(-2.593649734646368e-3)-t4.*(t40-t43).*2.938539014000548e-1;
et4 = p1cut2-t13.*3.421289764284745e-2+t14.*9.294503859640228e-2-t21.*9.294503859640228e-2-t22.*3.421289764284745e-2;
et5 = t5.*(t15+t8.*(t41-t44)).*(-2.593649734646368e-3)-t9.*(t15+t8.*(t41-t44)).*5.068505235394203e-2+R1cut2_3.*t8.*2.938539014000548e-1+t5.*t53.*5.068505235394203e-2;
et6 = t9.*t53.*(-2.593649734646368e-3)-t4.*(t41-t44).*2.938539014000548e-1;
et7 = p1cut3-t16.*3.421289764284745e-2+t17.*9.294503859640228e-2-t23.*9.294503859640228e-2-t24.*3.421289764284745e-2;
et8 = t5.*(t18+t8.*(t42-t45)).*(-2.593649734646368e-3)-t9.*(t18+t8.*(t42-t45)).*5.068505235394203e-2+R1cut3_3.*t8.*2.938539014000548e-1+t5.*t54.*5.068505235394203e-2;
et9 = t9.*t54.*(-2.593649734646368e-3)-t4.*(t42-t45).*2.938539014000548e-1;
out1 = [et1+et2+et3;et4+et5+et6;et7+et8+et9];
end
