function out1 = R_Toe_Tip_Position(in1,in2,in3)
%R_Toe_Tip_Position
%    OUT1 = R_Toe_Tip_Position(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    20-Mar-2024 14:55:23

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
q11 = in1(9,:);
q12 = in1(10,:);
t2 = cos(q10);
t3 = cos(q11);
t4 = cos(q12);
t5 = sin(q10);
t6 = sin(q11);
t7 = sin(q12);
t8 = R3cut1_1.*t2;
t9 = R3cut1_2.*t2;
t10 = R3cut2_1.*t2;
t11 = R3cut2_2.*t2;
t12 = R3cut3_1.*t2;
t13 = R3cut3_2.*t2;
t14 = R3cut1_1.*t5;
t15 = R3cut1_2.*t5;
t16 = R3cut2_1.*t5;
t17 = R3cut2_2.*t5;
t18 = R3cut3_1.*t5;
t19 = R3cut3_2.*t5;
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
t72 = t30+t41-9.520897236789891e-2;
t74 = t35+t38-1.02821530761636e-1;
t76 = t39+t44-1.70389961065884e-1;
t78 = t34+t50-4.760448697112906e-1;
t80 = t32+t48-1.82747152541975e-2;
t82 = t37+t43-7.314389686579541e-2;
t26 = t9+t20;
t27 = t11+t21;
t28 = t13+t22;
t62 = R3cut1_3.*t58;
t63 = R3cut2_3.*t58;
t64 = R3cut3_3.*t58;
t65 = t23.*t54;
t67 = t24.*t54;
t69 = t25.*t54;
t71 = t30+t49+9.520897236789891e-2;
t73 = t35+t45+1.02821530761636e-1;
t75 = t44+t47+1.70389961065884e-1;
t77 = t42+t50+4.760448697112906e-1;
t79 = t32+t52+1.82747152541975e-2;
t81 = t37+t51+7.314389686579541e-2;
t83 = R3cut1_3.*t74;
t84 = R3cut2_3.*t74;
t85 = R3cut3_3.*t74;
t92 = t23.*t80;
t93 = t24.*t80;
t94 = t25.*t80;
t59 = t26.*t53;
t60 = t27.*t53;
t61 = t28.*t53;
t86 = R3cut1_3.*t75;
t87 = R3cut2_3.*t75;
t88 = R3cut3_3.*t75;
t89 = t23.*t73;
t90 = t24.*t73;
t91 = t25.*t73;
t98 = t26.*t76;
t99 = t27.*t76;
t100 = t28.*t76;
t101 = t26.*t79;
t102 = t27.*t79;
t103 = t28.*t79;
t66 = -t59;
t68 = -t60;
t70 = -t61;
t95 = -t89;
t96 = -t90;
t97 = -t91;
t107 = t65+t83+t101;
t108 = t67+t84+t102;
t109 = t69+t85+t103;
t104 = t66+t86+t92;
t105 = t68+t87+t93;
t106 = t70+t88+t94;
t110 = t62+t95+t98;
t111 = t63+t96+t99;
t112 = t64+t97+t100;
et1 = p3cut1-t9.*3.843564448380243e-1+t14.*3.843564448380243e-1-t59.*3.807832337118239e-2+t62.*7.189042219303086e-3-t65.*4.426888750447116e-2;
et2 = t83.*(-4.426888750447116e-2)+t86.*3.807832337118239e-2-t89.*7.189042219303086e-3+t92.*3.807832337118239e-2+t98.*7.189042219303086e-3;
et3 = t101.*(-4.426888750447116e-2)-t57.*t104.*7.413899821169304e-3+t56.*t107.*2.360401842715321e-1-t55.*t110.*8.873080565218881e-3-t72.*t107.*8.873080565218881e-3;
et4 = t71.*t110.*(-2.360401842715321e-1)+t78.*t104.*2.360401842715321e-1+t77.*t107.*7.413899821169304e-3-t81.*t104.*8.873080565218881e-3+t82.*t110.*7.413899821169304e-3;
et5 = p3cut2-t11.*3.843564448380243e-1+t16.*3.843564448380243e-1-t60.*3.807832337118239e-2+t63.*7.189042219303086e-3-t67.*4.426888750447116e-2;
et6 = t84.*(-4.426888750447116e-2)+t87.*3.807832337118239e-2-t90.*7.189042219303086e-3+t93.*3.807832337118239e-2+t99.*7.189042219303086e-3;
et7 = t102.*(-4.426888750447116e-2)-t57.*t105.*7.413899821169304e-3+t56.*t108.*2.360401842715321e-1-t55.*t111.*8.873080565218881e-3-t72.*t108.*8.873080565218881e-3;
et8 = t71.*t111.*(-2.360401842715321e-1)+t78.*t105.*2.360401842715321e-1+t77.*t108.*7.413899821169304e-3-t81.*t105.*8.873080565218881e-3+t82.*t111.*7.413899821169304e-3;
et9 = p3cut3-t13.*3.843564448380243e-1+t18.*3.843564448380243e-1-t61.*3.807832337118239e-2+t64.*7.189042219303086e-3-t69.*4.426888750447116e-2;
et10 = t85.*(-4.426888750447116e-2)+t88.*3.807832337118239e-2-t91.*7.189042219303086e-3+t94.*3.807832337118239e-2+t100.*7.189042219303086e-3;
et11 = t103.*(-4.426888750447116e-2)-t57.*t106.*7.413899821169304e-3+t56.*t109.*2.360401842715321e-1-t55.*t112.*8.873080565218881e-3-t72.*t109.*8.873080565218881e-3;
et12 = t71.*t112.*(-2.360401842715321e-1)+t78.*t106.*2.360401842715321e-1+t77.*t109.*7.413899821169304e-3-t81.*t106.*8.873080565218881e-3+t82.*t112.*7.413899821169304e-3;
out1 = [et1+et2+et3+et4;et5+et6+et7+et8;et9+et10+et11+et12];
end
