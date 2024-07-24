function [Markers]=Marker_set_13_markers(nb_markers_hand)
% Definition of the markers set used in the M2S
%
%   INPUT
%   - nb_markers_hand: number of markers used on each hand
%   OUTPUT
%   - Markers: set of markers (see the Documentation for the structure) 
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________
s=cell(0);

% Trunk
s=[s;{'Sternum' 'STRN' {'Off';'On';'Off'};'CLAV' 'CLAV' {'On';'Off';'Off'};'T10' 'T10' {'Off';'On';'Off'};...
    'C7' 'C7' {'On';'On';'Off'};'R_Acromium' 'RSHO' {'On';'Off';'On'};'L_Acromium' 'LSHO' {'On';'Off';'On'};'R_ASIS' 'RFWT' {'On';'Off';'On'};...
    'L_ASIS' 'LFWT' {'On';'Off';'On'};'RBWT' 'RBWT' {'On';'Off';'On'};'LBWT' 'LBWT' {'On';'Off';'On'};...
    'RFHD' 'RFHD' {'Off';'Off';'On'};'LFHD' 'LFHD' {'Off';'Off';'On'};'RBHD' 'RBHD' {'Off';'On';'On'};'LBHD' 'LBHD' {'Off';'On';'On'}}];

Side={'R';'L'};
% Leg
for i=1:2
    Signe=Side{i};
    s=[s;{[Signe '_Shank_Upper'] [Signe 'KNE'] {'Off';'Off';'Off'};[Signe '_Ankle_Lat'] [Signe 'ANE'] {'Off';'On';'Off'};[Signe '_Ankle_Med'] [Signe 'ANI'] {'Off';'Off';'Off'};...
        [Signe '_Knee_Med'] [Signe 'KNI'] {'Off';'On';'On'};[Signe '_Heel'] [Signe 'HEE'] {'Off';'On';'Off'};[Signe 'TAR'] [Signe 'TAR'] {'Off';'On';'On'};...
        [Signe '_Toe_Tip'] [Signe 'TOE'] {'Off';'Off';'Off'};...
        [Signe '_Midfoot_Sup'] [Signe 'TARI'] {'Off';'On';'On'}}];
%         }]; %#ok<AGROW>
end


% Arm
for i=1:2
    Signe=Side{i};
    s=[s;{[Signe 'HUM'] [Signe 'HUM'] {'Off';'Off';'Off'};[Signe 'RAD'] [Signe 'RAD'] {'On';'On';'Off'};...
        [Signe 'WRA'] [Signe 'WRA'] {'Off';'Off';'Off'};[Signe 'WRB'] [Signe 'WRB'] {'Off';'On';'Off'}}]; %#ok<AGROW>
    eval(['s=Hand_markers_' num2str(nb_markers_hand) '(s,Signe);'])
end

Markers=struct('name',{s{:,1}}','anat_position',{s{:,2}}','calib_dir',{s{:,3}}'); %#ok<CCAT1>

end
function [s]=Hand_markers_1(s,Signe)   %#ok<DEFNU>
% 1 marker on the hand
    s=[s;{[Signe 'CAR'] [Signe 'CAR1'] {'Off';'Off';'Off'}}];   
end
function [s]=Hand_markers_2(s,Signe)   %#ok<DEFNU>  
% 2 markers on the hand
    s=[s;{[Signe 'CAR'] [Signe 'CAR2'] {'Off';'Off';'Off'};[Signe 'OHAND'] [Signe 'OHAND'] {'Off';'Off';'Off'}}];    
end    
function [s]=Hand_markers_3(s,Signe)   %#ok<DEFNU>  
% 3 markers on the hand
    s=[s;{[Signe 'CAR'] [Signe 'CAR3'] {'Off';'Off';'Off'};[Signe 'IDX3'] [Signe 'IDX3'] {'Off';'Off';'Off'};[Signe 'PNK3'] [Signe 'PNK3'] {'Off';'Off';'Off'}}];    
end