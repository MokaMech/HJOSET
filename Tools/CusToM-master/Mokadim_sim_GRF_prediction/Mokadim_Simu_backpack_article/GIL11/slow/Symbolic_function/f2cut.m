function [R2cut,p2cut] = f2cut(in1,in2,in3)
%F2CUT
%    [R2cut,P2CUT] = F2CUT(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    30-Mar-2024 18:07:18

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
q19 = in1(15,:);
t2 = cos(q1);
t3 = cos(q14);
t4 = cos(q15);
t5 = cos(q16);
t6 = sin(q1);
t7 = sin(q14);
t8 = sin(q15);
t9 = sin(q16);
t10 = q19.^2;
t11 = q19.^3;
t13 = q19.^5;
t32 = q19.*(3.0./2.0);
t33 = q19.*(3.0./4.0);
t44 = q19.*(9.0./4.0);
t86 = q19.*3.601279641763585e-3;
t12 = t10.^2;
t14 = R1cut1_1.*t2;
t15 = R1cut1_2.*t2;
t16 = R1cut2_1.*t2;
t17 = R1cut2_2.*t2;
t18 = R1cut1_3.*t4;
t19 = R1cut3_1.*t2;
t20 = R1cut3_2.*t2;
t21 = R1cut2_3.*t4;
t22 = R1cut3_3.*t4;
t23 = R1cut1_1.*t6;
t24 = R1cut1_2.*t6;
t25 = R1cut2_1.*t6;
t26 = R1cut2_2.*t6;
t27 = R1cut1_3.*t8;
t28 = R1cut3_1.*t6;
t29 = R1cut3_2.*t6;
t30 = R1cut2_3.*t8;
t31 = R1cut3_3.*t8;
t34 = cos(t32);
t35 = cos(t33);
t36 = sin(t32);
t37 = sin(t33);
t45 = cos(t44);
t46 = sin(t44);
t90 = t10.*2.976490981715895e-3;
t91 = t11.*2.07254621815263e-3;
t92 = t13.*3.501866365060014e-4;
t41 = -t23;
t42 = -t25;
t43 = -t28;
t47 = t14+t24;
t48 = t16+t26;
t49 = t19+t29;
t93 = -t90;
t97 = -t92;
t98 = t36.*5.095272021099585e-3;
t99 = t12.*2.096403832015052e-5;
t100 = t35.*5.30624666312156e-4;
t101 = t34.*1.109257784497757e-3;
t103 = t37.*1.413998934085053e-4;
t104 = t45.*2.594519264332454e-3;
t106 = t46.*8.579635442226943e-4;
t50 = t15+t41;
t51 = t17+t42;
t52 = t20+t43;
t53 = t3.*t47;
t54 = t3.*t48;
t55 = t3.*t49;
t56 = t7.*t47;
t57 = t7.*t48;
t58 = t7.*t49;
t102 = -t100;
t105 = -t101;
t107 = -t106;
t111 = t86+t91+t93+t97+t99+3.870115532742981e-2;
t59 = t3.*t50;
t60 = t3.*t51;
t61 = t3.*t52;
t62 = t7.*t50;
t64 = t7.*t51;
t66 = t7.*t52;
t112 = t98+t102+t103+t104+t105+t107+7.045615378458278e-3;
t68 = t53+t62;
t69 = t54+t64;
t70 = t55+t66;
t77 = -t4.*(t56-t59);
t78 = -t4.*(t57-t60);
t79 = -t4.*(t58-t61);
t94 = -t9.*(t18+t8.*(t56-t59));
t95 = -t9.*(t21+t8.*(t57-t60));
t96 = -t9.*(t22+t8.*(t58-t61));
t74 = t5.*t68;
t75 = t5.*t69;
t76 = t5.*t70;
t83 = t27+t77;
t84 = t30+t78;
t85 = t31+t79;
t108 = t74+t94;
t109 = t75+t95;
t110 = t76+t96;
R2cut = reshape([t108,t109,t110,t83,t84,t85,t5.*(t18+t8.*(t56-t59))+t9.*t68,t5.*(t21+t8.*(t57-t60))+t9.*t69,t5.*(t22+t8.*(t58-t61))+t9.*t70],[3,3]);
if nargout > 1
    mt1 = [R1cut1_3.*(-8.029826264886657e-2)+p1cut1-t15.*6.356545103101893e-2+t23.*6.356545103101893e-2-t27.*3.711278369435436e-1+t83.*t111-t108.*t112+t4.*(t56-t59).*3.711278369435436e-1];
    mt2 = [R1cut2_3.*(-8.029826264886657e-2)+p1cut2-t17.*6.356545103101893e-2+t25.*6.356545103101893e-2-t30.*3.711278369435436e-1+t84.*t111-t109.*t112+t4.*(t57-t60).*3.711278369435436e-1];
    mt3 = [R1cut3_3.*(-8.029826264886657e-2)+p1cut3-t20.*6.356545103101893e-2+t28.*6.356545103101893e-2-t31.*3.711278369435436e-1+t85.*t111-t110.*t112+t4.*(t58-t61).*3.711278369435436e-1];
    p2cut = [mt1;mt2;mt3];
end
end
