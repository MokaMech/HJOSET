function [R1cut,p1cut] = f1cut(in1,in2,in3)
%F1CUT
%    [R1cut,P1CUT] = F1CUT(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    02-Apr-2024 17:47:34

q24 = in1(19,:);
q25 = in1(20,:);
q26 = in1(21,:);
q27 = in1(22,:);
q28 = in1(23,:);
t2 = cos(q27);
t3 = cos(q28);
t4 = sin(q27);
t5 = sin(q28);
R1cut = reshape([t3,t4.*t5,-t2.*t5,0.0,t2,t4,t5,-t3.*t4,t2.*t3],[3,3]);
if nargout > 1
    p1cut = [q24;q25;q26];
end
end
