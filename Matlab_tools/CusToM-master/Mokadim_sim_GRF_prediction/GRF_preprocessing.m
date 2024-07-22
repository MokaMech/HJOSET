% ----------------------------------------------------------------------- %
% Pre processing for GRF prediction of gait motion via experimental motion
% capture
% Input :  marker position dataset as .trc file
% Output : marker postition dataset as .c3d file
% Runs install of necessary packages and scripts necessary to the rest of
% the computation.
% Author : L Moreno Carbonell CEA LIST DIASI SRI LASR
% ----------------------------------------------------------------------- %


%% Install libraries and add required path
import org.opensim.modeling.*
GRF_prediction_dir = pwd;
cd ..
Installation
addpath OpenSim_Utilities 
cd(GRF_prediction_dir)


%% Get the path to a trc file
[trc_filename, dir] = uigetfile('*.trc');
trc_path = fullfile(dir,trc_filename);


%% Write marker data to c3d file.
writeC3D(trc_path);


%% Move to directory containing data to run the computation
cd(dir);
addpath(GRF_prediction_dir)

%% Functions

function convert_m_to_mm(data, unit)
    % Function to convert  point data (m) to mm
    arguments
        data                % matlab structure constructed from TimeSeriesTableVec3
        unit                {string}
    end

    if strcmp(unit,'m')
        disp 'Convert markers positions from m to mm.'
        for label = fieldnames(data)
            data.(label) = 1000 * data.(label);
        end
    elseif strcmp(unit,'mm')
        disp 'Markers positions already in mm, no conversion necessary'
    else
        error('Check markers positions : only m and mm are handled.')
    end
end


function rotate_table(table, axisString, angle)
    % Function to rotate data for consistency between file formats
    % CusToM : z = upwards 
    % OpenSim : y = upwards
    
    arguments
        table               % OpenSim TimeSeriesTableVec3 object
        axisString          {string}
        angle               {double}
    end
    
    % Necessary for the compiler to recognize the CoordinateAxis function
    import org.opensim.modeling.*

    % Check formats
    if ~ischar(axisString)
        error('Axis must be either x,y or z')
    end
    if ~isnumeric(angle)
        error('value must be numeric (90, -90, 270, ...')
    end
    % Set up the transform
    if strcmp(axisString, 'x')
        axis = CoordinateAxis(0);
    elseif strcmp(axisString, 'y')
        axis = CoordinateAxis(1);
    elseif strcmp(axisString, 'z')
        axis = CoordinateAxis(2);
    else
        error('input axis must be either x,y, or z')
    end
    
    % instantiate a transform selfect. Rotation() is a Simbody class
    R = Rotation( deg2rad(angle) , axis ) ;
    
    % Rotation() works on each row.
    for iRow = 0 : table.getNumRows() - 1
        % get a row from the table
        rowVec = table.getRowAtIndex(iRow);
        % rotate each Vec3 element of row vector, rowVec, at once
        rowVec_rotated = R.multiply(rowVec);
        % overwrite row with rotated row
        table.setRowAtIndex(iRow,rowVec_rotated);
     end
end


function writeC3D(path)
    % Function to extract marker data from the trc file and write in the c3d file

    arguments
        path                             {mustBeTextScalar}
    end
    
    % Necessary for the compiler to recognize the TimeSeriesTableVec3 function
    import org.opensim.modeling.*

    % Construct an opensimTRC and an opensimOSIM object with input path
    try
        table = TimeSeriesTableVec3(path);
    catch error
        disp('Error happened')
    end
    
    % Retrieve useful metadata
    frames_number = str2double(table.getTableMetaDataAsString('NumFrames'));
    markers_number = str2double(table.getTableMetaDataAsString('NumMarkers'));
    markers_rate = str2double(table.getTableMetaDataAsString('DataRate'));
    
    % Rotate table
    rotate_table(table,'x',90);
    
    % Traduce table in matlab array
    data = osimTableToStruct(table);

    % Convert to meters if necessary
    unit = char(table.getTableMetaDataAsString('Units'));
    convert_m_to_mm(data,unit);

    % Get labels
    labels = fieldnames(data);

    % Number of markers and frames
    acq = btkNewAcquisition(markers_number , frames_number);

    % Sampling frequency
    btkSetFrequency(acq, markers_rate);

    % Write marker data
    for i = 1:markers_number
        disp(['[', labels{i} ,']---------------------------------------------------- Writing...'])
        btkSetPointLabel(acq, i , labels{i});
        btkSetPoint(acq, i, data.(labels{i}));
        disp(['[', labels{i}, ']---------------------------------------------------- Done'])
    end

    relative_output_path = [path(length(fileparts(fileparts(path)))+2:length(path)-length('.trc')) '.c3d'];
    disp('');
    disp(['Writing c3d file to ' relative_output_path]);
    btkWriteAcquisition(acq, relative_output_path);

end