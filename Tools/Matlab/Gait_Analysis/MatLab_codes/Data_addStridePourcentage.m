function var_out = Data_addStridePourcentage(inputArg1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
var_in = inputname(inputArg1)
buffer = (var_in(:,1)-var_in(1,1))/(var_in(end,1)-var_in(1,1))
var_out = [buffer inputArg1]
end

