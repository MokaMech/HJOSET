Data = whos('GIL*');

for i = 1:size(Data,1)
   arg = Data(i).name;
    = Data_addStridePourcentage(arg);
end