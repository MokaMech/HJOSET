function out1 = L_Toe_Tip_Position(in1,in2,in3)
%L_Toe_Tip_Position
%    OUT1 = L_Toe_Tip_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    30-Mar-2024 21:23:21

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
q20 = in1(16,:);
q21 = in1(17,:);
t2 = cos(q19);
t3 = cos(q20);
t4 = cos(q21);
t5 = sin(q19);
t6 = sin(q20);
t7 = sin(q21);
t8 = R2cut1_1.*t2;
t9 = R2cut1_2.*t2;
t10 = R2cut2_1.*t2;
t11 = R2cut2_2.*t2;
t12 = R2cut3_1.*t2;
t13 = R2cut3_2.*t2;
t14 = R2cut1_1.*t5;
t15 = R2cut1_2.*t5;
t16 = R2cut2_1.*t5;
t17 = R2cut2_2.*t5;
t18 = R2cut3_1.*t5;
t19 = R2cut3_2.*t5;
t29 = t3.*9.697161962003449e-1;
t30 = t7.*6.0474746e-1;
t31 = t3.*9.889721636207449e-1;
t32 = t6.*9.7912632e-1;
t33 = t4.*9.853712287762038e-1;
t34 = t4.*4.760448697112906e-1;
t35 = t6.*1.7402245e-1;
t36 = t4.*3.803482695077117e-1;
t37 = t7.*7.8717961e-1;
t38 = t3.*1.02821530761636e-1;
t39 = t3.*1.70389961065884e-1;
t40 = t4.*6.342805175310123e-1;
t41 = t4.*9.520897236789891e-2;
t43 = t4.*7.314389686579541e-2;
t44 = t6.*1.0501355e-1;
t46 = t3.*4.1311658787605e-2;
t48 = t3.*1.82747152541975e-2;
t50 = t7.*1.2094949e-1;
t20 = -t14;
t21 = -t16;
t22 = -t18;
t23 = t8+t15;
t24 = t10+t17;
t25 = t12+t19;
t42 = -t34;
t45 = -t38;
t47 = -t39;
t49 = -t41;
t51 = -t43;
t52 = -t48;
t53 = t29+3.028380379965512e-2;
t54 = t31+1.102783637925508e-2;
t55 = t33+1.462877122379624e-2;
t56 = t36+6.196517304922883e-1;
t57 = t40+3.657194824689877e-1;
t58 = t46+9.58688341212395e-1;
t69 = t30+t41-9.520897236789891e-2;
t71 = t35+t38-1.02821530761636e-1;
t73 = t39+t44-1.70389961065884e-1;
t75 = t34+t50-4.760448697112906e-1;
t77 = t32+t48-1.82747152541975e-2;
t79 = t37+t43-7.314389686579541e-2;
t26 = t9+t20;
t27 = t11+t21;
t28 = t13+t22;
t62 = R2cut1_3.*t58;
t63 = R2cut2_3.*t58;
t64 = R2cut3_3.*t58;
t65 = t23.*t54;
t66 = t24.*t54;
t67 = t25.*t54;
t68 = t30+t49+9.520897236789891e-2;
t70 = t35+t45+1.02821530761636e-1;
t72 = t44+t47+1.70389961065884e-1;
t74 = t42+t50+4.760448697112906e-1;
t76 = t32+t52+1.82747152541975e-2;
t78 = t37+t51+7.314389686579541e-2;
t80 = R2cut1_3.*t71;
t81 = R2cut2_3.*t71;
t82 = R2cut3_3.*t71;
t92 = t23.*t77;
t93 = t24.*t77;
t94 = t25.*t77;
t59 = t26.*t53;
t60 = t27.*t53;
t61 = t28.*t53;
t83 = R2cut1_3.*t72;
t84 = R2cut2_3.*t72;
t85 = R2cut3_3.*t72;
t86 = -t80;
t87 = -t81;
t88 = -t82;
t89 = t23.*t70;
t90 = t24.*t70;
t91 = t25.*t70;
t95 = t26.*t73;
t96 = t27.*t73;
t97 = t28.*t73;
t98 = t26.*t76;
t99 = -t92;
t100 = t27.*t76;
t101 = -t93;
t102 = t28.*t76;
t103 = -t94;
t104 = -t95;
t105 = -t96;
t106 = -t97;
t107 = t59+t83+t99;
t108 = t60+t84+t101;
t109 = t61+t85+t103;
t110 = t65+t86+t98;
t111 = t66+t87+t100;
t112 = t67+t88+t102;
t113 = t62+t89+t104;
t114 = t63+t90+t105;
t115 = t64+t91+t106;
et1 = p2cut1-t9.*4.432678471488969e-1+t14.*4.432678471488969e-1-t59.*4.149347037427905e-2-t62.*7.83380894789726e-3-t65.*4.823925030163502e-2;
et2 = t80.*4.823925030163502e-2-t83.*4.149347037427905e-2-t89.*7.83380894789726e-3+t92.*4.149347037427905e-2+t95.*7.83380894789726e-3;
et3 = t98.*(-4.823925030163502e-2)+t57.*t107.*3.745908630720332e-2+t56.*t110.*2.513663750431522e-1+t55.*t113.*3.299915289631539e-2-t69.*t110.*3.299915289631539e-2;
et4 = t68.*t113.*2.513663750431522e-1-t75.*t107.*2.513663750431522e-1+t74.*t110.*3.745908630720332e-2+t78.*t107.*3.299915289631539e-2-t79.*t113.*3.745908630720332e-2;
et5 = p2cut2-t11.*4.432678471488969e-1+t16.*4.432678471488969e-1-t60.*4.149347037427905e-2-t63.*7.83380894789726e-3-t66.*4.823925030163502e-2;
et6 = t81.*4.823925030163502e-2-t84.*4.149347037427905e-2-t90.*7.83380894789726e-3+t93.*4.149347037427905e-2+t96.*7.83380894789726e-3;
et7 = t100.*(-4.823925030163502e-2)+t57.*t108.*3.745908630720332e-2+t56.*t111.*2.513663750431522e-1+t55.*t114.*3.299915289631539e-2-t69.*t111.*3.299915289631539e-2;
et8 = t68.*t114.*2.513663750431522e-1-t75.*t108.*2.513663750431522e-1+t74.*t111.*3.745908630720332e-2+t78.*t108.*3.299915289631539e-2-t79.*t114.*3.745908630720332e-2;
et9 = p2cut3-t13.*4.432678471488969e-1+t18.*4.432678471488969e-1-t61.*4.149347037427905e-2-t64.*7.83380894789726e-3-t67.*4.823925030163502e-2;
et10 = t82.*4.823925030163502e-2-t85.*4.149347037427905e-2-t91.*7.83380894789726e-3+t94.*4.149347037427905e-2+t97.*7.83380894789726e-3;
et11 = t102.*(-4.823925030163502e-2)+t57.*t109.*3.745908630720332e-2+t56.*t112.*2.513663750431522e-1+t55.*t115.*3.299915289631539e-2-t69.*t112.*3.299915289631539e-2;
et12 = t68.*t115.*2.513663750431522e-1-t75.*t109.*2.513663750431522e-1+t74.*t112.*3.745908630720332e-2+t78.*t109.*3.299915289631539e-2-t79.*t115.*3.745908630720332e-2;
out1 = [et1+et2+et3+et4;et5+et6+et7+et8;et9+et10+et11+et12];
end
