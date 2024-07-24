%%
% This code has been written by Thomas Mokadim
%
% The code below translates a full-body gait MoCap task registered with any
% other markerset than the one used in 2354 and 2392 gait models used in
% OpenSim 4.0 and earlier.
% This default markerset provided with the OpenSim Gait2354 model is used
% as the common markerset for CusToM and OpenSim software run by Mokadim et
% al. 2024 experiment described in the article above.
%
%
% 
% For each GIL experiment you are intested in :
% Step 1 : Open in OpenSim the GILXX_10DOF_78Markers.osim model
%          This model fits the old GIL markerSet and the one used in
%          Gait2392 or Gait 2354, as well used in CusToM Toolbox.
%          Run the AnalyseTool with the xml setup File
%          'GILXX_Analyse_Setup_for_markersOutput'
%
%               - INPUTS : GIL11_'spd'.trc       File containing the gait
%               kinematics expressed with the old marketSet.
%
%               * OUTPUTS : GIL_OutputsVec3.sto   File containing the gait
%               kinematics expressed with the new marketSet.
%
% Step 2 : In the Matlab_code section, run the CusToM_for_GRF/outputVec3toTRC.m file
%          Follow the instructions : select the OutputsVec3.sto file to
%          extract data from.
%
%               - INPUTS : GIL_OutputsVec3.sto  Containts the markers
%                          coords in Vec3 format [X,Y,Z] with labels
%                          (markerset/NAME|location)
%
%               * OUPUTS : OutputLabels : Contains the markers labels
%                          OutputData   : Contains the markers coords in
%                                         [ X ] [ Y ] [ Z ] format.
%                          Defaut Output unit is mm as .sto coords are in
%                          meter, a scaling factor is applied.
%
% Step 3 : Copy paste the new coords in a copy of the original .trc file
%          ==> Check header
%          ==> Check Time serie (should be the same)
%          ==> Swap old markers labels by OutputLabels
%          ==> Check Xi,Yi,Zi count matches the number of new labels.
%          ==> Paste OuputData in place of old data. 
%
%               - INPUTS : GIL11_'spd'.trc
%               - OUPUTS : GIL11_'spd'_newCoords.trc
% 
% Step 4 : Verify file integrity bu opening the new .trc file in OpenSim or
%          Mokka.
%%
[file,path] = uigetfile('.sto');

InputLabels = importGILVect3ColNames([path file]);
InputLabels_size = size(InputLabels);
%OutputLabels = zeros(InputLabels_size));

InputData = importGILVect3Data([path file]);
InputData_size = size(InputData);
OutputData = zeros(InputData_size(1),3*InputData_size(2));
%%
for i = 1:InputLabels_size(2)
    label = strsplit(InputLabels(i),'/');
    label = strsplit(label(3),'|');
    OutputLabels(i) = label(1);
end

%%
rotate_90_OpenSim_CusToM = 1; % OpenSim ==> CusToM : X==>X, Y==>Z, Z==>-Y
for i = 1:InputData_size(1)
    k = 1;
    for j = 1:InputData_size(2)
        cell = InputData(i,j);
        cell_splited = strsplit(cell,',');
        if rotate_90_OpenSim_CusToM == 1
            OutputData(i,k) = str2double(cell_splited(1,1))*1000;
            OutputData(i,k+1) = str2double(cell_splited(1,3))*-1000;
            OutputData(i,k+2) = str2double(cell_splited(1,2))*1000; 
            k = k + 3;
        else
            OutputData(i,k) = str2double(cell_splited(1,1))*1000;
            OutputData(i,k+1) = str2double(cell_splited(1,2))*1000;
            OutputData(i,k+2) = str2double(cell_splited(1,3))*1000; 
            k = k + 3;
        end
    end
end
