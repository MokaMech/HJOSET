function GIL0610DOFnoLoadadjustedActuationforce = importNoLoadRRAAnkleTorques(filename, dataLines)
%IMPORTFILE Import data from a text file
%  GIL0610DOFNOLOADADJUSTEDACTUATIONFORCE = IMPORTFILE(FILENAME) reads
%  data from text file FILENAME for the default selection.  Returns the
%  numeric data.
%
%  GIL0610DOFNOLOADADJUSTEDACTUATIONFORCE = IMPORTFILE(FILE, DATALINES)
%  reads data for the specified row interval(s) of text file FILENAME.
%  Specify DATALINES as a positive scalar integer or a N-by-2 array of
%  positive scalar integers for dis-contiguous row intervals.
%
%  Example:
%  GIL0610DOFnoLoadadjustedActuationforce = importfile("C:\Users\tm262836\Desktop\Mokadim_Simulation\experiment\GIL06\GIL06_free\Gait10dof18musc\RRA\ResultsRRA\GIL06_10DOF_noLoad_adjusted_Actuation_force.sto", [24, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 20-Apr-2024 19:13:17

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [24, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 11);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["ActuatorForces", "Var2", "Var3", "Var4", "Var5", "Var6", "VarName7", "Var8", "Var9", "VarName10", "Var11"];
opts.SelectedVariableNames = ["ActuatorForces", "VarName7", "VarName10"];
opts.VariableTypes = ["double", "string", "string", "string", "string", "string", "double", "string", "string", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var8", "Var9", "Var11"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "Var6", "Var8", "Var9", "Var11"], "EmptyFieldRule", "auto");

% Import the data
GIL0610DOFnoLoadadjustedActuationforce = readtable(filename, opts);

%% Convert to output type
GIL0610DOFnoLoadadjustedActuationforce = table2array(GIL0610DOFnoLoadadjustedActuationforce);
end