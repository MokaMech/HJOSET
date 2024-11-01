function GIL0610DOFbackpackadjustedActuationforce = importRRAAnkleTorques(filename, dataLines)
%IMPORTFILE Import data from a text file
%  GIL0610DOFBACKPACKADJUSTEDACTUATIONFORCE = IMPORTFILE(FILENAME) reads
%  data from text file FILENAME for the default selection.  Returns the
%  numeric data.
%
%  GIL0610DOFBACKPACKADJUSTEDACTUATIONFORCE = IMPORTFILE(FILE,
%  DATALINES) reads data for the specified row interval(s) of text file
%  FILENAME. Specify DATALINES as a positive scalar integer or a N-by-2
%  array of positive scalar integers for dis-contiguous row intervals.
%
%  Example:
%  GIL0610DOFbackpackadjustedActuationforce = importfile("C:\Users\tm262836\Desktop\Mokadim_Simulation\experiment\GIL06\GIL06_free\Gait10dof18musc_backpack\RRA\RRAResults\GIL06_10DOF_backpack_adjusted_Actuation_force.sto", [24, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 16-Apr-2024 11:42:26

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [24, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 12);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["ActuatorForces", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "VarName8", "Var9", "Var10", "VarName11", "Var12"];
opts.SelectedVariableNames = ["ActuatorForces", "VarName8", "VarName11"];
opts.VariableTypes = ["double", "string", "string", "string", "string", "string", "string", "double", "string", "string", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var9", "Var10", "Var12"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var9", "Var10", "Var12"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["ActuatorForces", "VarName8", "VarName11"], "ThousandsSeparator", ",");

% Import the data
GIL0610DOFbackpackadjustedActuationforce = readtable(filename, opts);

%% Convert to output type
GIL0610DOFbackpackadjustedActuationforce = table2array(GIL0610DOFbackpackadjustedActuationforce);
end