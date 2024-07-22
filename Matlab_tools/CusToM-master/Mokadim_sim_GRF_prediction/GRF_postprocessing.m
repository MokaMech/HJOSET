% ----------------------------------------------------------------------- %
% Post processing for GRF prediction of gait motion via experimental motion
% capture
% Input :  GRF prediction results (forces, torques and Center of pressure
%          positions) as matlab structure.
% Output : GRF prediction results (forces, torques and Center of pressure
%          positions) as OpenSim compatible .mot format
% Script filters GRF during swingphase for each foot, rotates the data to
% match OpenSim's ground frame and checks unit conversion.
% 
% Author : L Moreno Carbonell CEA LIST DIASI SRI LASR
% ----------------------------------------------------------------------- %



%% Load OpenSim libs
import org.opensim.modeling.*


%% Get the path to the .mat data and access the data
[data_name, data_dir] = uigetfile(('*.mat'));

%% Options
filterData = 0;
convertToMot = 1;

%% Filter data in swing phase

    unfiltered_data_path = fullfile(data_dir, data_name);
    filtered_data_path = fullfile(data_dir, 'ExternalForcesComputationFilteredResults.mat');
    
    copyfile(unfiltered_data_path,filtered_data_path);
    
    data = load(filtered_data_path);
    
    ext_f_prediction = data.ExternalForcesComputationResults.ExternalForcesPrediction;
    
    ext_f_prediction_size = size(ext_f_prediction);
    frames_number = ext_f_prediction_size(2);
    
    r_foot_index = get_body_index('calcn_r');
    l_foot_index = get_body_index('calcn_l');
    
    if filterData

    disp(' ');
    disp('Filtering data -------------------------------------------- ...');
    
    threshold = get_threshold_by_force_max(filtered_data_path);
    
    % Right foot
    disp('  Right foot...');
    % 1st frame
    if ext_f_prediction(1).fext(r_foot_index).fext(3,1) < threshold
        % ToeOff fond
        ToeOff_index = 1;
    
        rpx_start = ext_f_prediction(ToeOff_index).Visual(1,1);
        rpy_start = ext_f_prediction(ToeOff_index).Visual(2,1);
        rpz_start = ext_f_prediction(ToeOff_index).Visual(3,1);
    
        ext_f_prediction(1).fext(r_foot_index).fext(1,1) = 0;     % rfx
        ext_f_prediction(1).fext(r_foot_index).fext(2,1) = 0;     % rfy
        ext_f_prediction(1).fext(r_foot_index).fext(3,1) = 0;     % rfz
    
        ext_f_prediction(1).Visual(1,1) = ext_f_prediction(2).Visual(1,1);     % rpx
        ext_f_prediction(1).Visual(2,1) = ext_f_prediction(2).Visual(2,1);     % rpy
        ext_f_prediction(1).Visual(3,1) = ext_f_prediction(2).Visual(3,1);     % rpz
    
        ext_f_prediction(1).fext(r_foot_index).fext(1,2) = 0;     % rmx
        ext_f_prediction(1).fext(r_foot_index).fext(2,2) = 0;     % rmy
        ext_f_prediction(1).fext(r_foot_index).fext(3,2) = 0;     % rmz
    end
    
    % General case
    for frame_index = 2:frames_number
        if ext_f_prediction(frame_index).fext(r_foot_index).fext(3,1) < threshold
            if ext_f_prediction(frame_index-1).fext(r_foot_index).fext(3,1) > threshold
                % Toe Off found
                ToeOff_index = frame_index;
    
                rpx_start = ext_f_prediction(ToeOff_index).Visual(1,1);
                rpy_start = ext_f_prediction(ToeOff_index).Visual(2,1);
                rpz_start = ext_f_prediction(ToeOff_index).Visual(3,1);
            end
            if frame_index == frames_number
                % Heel Strike found
                HeelStrike_index = frame_index;
    
                rpx_end = ext_f_prediction(HeelStrike_index).Visual(1,1);
                rpy_end = ext_f_prediction(HeelStrike_index).Visual(2,1);
                rpz_end = ext_f_prediction(HeelStrike_index).Visual(3,1); 
    
                if ToeOff_index == HeelStrike_index
                    % Anomaly case
                    warning(['at frame ' num2str(frame_index) ' : swing phases should be longer than a single frame.'])
    
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(1,1) = 0;     % rfx
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(2,1) = 0;     % rfy
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(3,1) = 0;     % rfz
    
                    ext_f_prediction(ToeOff_index).Visual(1,1) = ext_f_prediction(ToeOff_index - 1).Visual(1,1) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                    ext_f_prediction(ToeOff_index).Visual(2,1) = ext_f_prediction(ToeOff_index - 1).Visual(2,1) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                    ext_f_prediction(ToeOff_index).Visual(3,1) = ext_f_prediction(ToeOff_index - 1).Visual(3,1) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(1,2) = 0;     % rmx
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(2,2) = 0;     % rmy
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(3,2) = 0;     % rmz
                else
                    for swing_index = max(ToeOff_index,2):HeelStrike_index-1
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(1,1) = 0;     % rfx
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(2,1) = 0;     % rfy
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(3,1) = 0;     % rfz
    
                        ext_f_prediction(swing_index).Visual(1,1) = ext_f_prediction(swing_index - 1).Visual(1,1) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                        ext_f_prediction(swing_index).Visual(2,1) = ext_f_prediction(swing_index - 1).Visual(2,1) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                        ext_f_prediction(swing_index).Visual(3,1) = ext_f_prediction(swing_index - 1).Visual(3,1) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(1,2) = 0;     % rmx
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(2,2) = 0;     % rmy
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(3,2) = 0;     % rmz
                    end
                end
            end
        else 
            if ext_f_prediction(frame_index-1).fext(r_foot_index).fext(3,1) < threshold
                % Heel Strike found
                HeelStrike_index = frame_index;
    
                rpx_end = ext_f_prediction(HeelStrike_index).Visual(1,1);
                rpy_end = ext_f_prediction(HeelStrike_index).Visual(2,1);
                rpz_end = ext_f_prediction(HeelStrike_index).Visual(3,1);
    
                % Rewrite swingphase
                if ToeOff_index == HeelStrike_index
                    % Anomaly case
                    warning(['at frame ' num2str(frame_index) ' : swing phases should be longer than a single frame.'])
    
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(1,1) = 0;     % rfx
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(2,1) = 0;     % rfy
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(3,1) = 0;     % rfz
    
                    ext_f_prediction(ToeOff_index).Visual(1,1) = ext_f_prediction(ToeOff_index - 1).Visual(1,1) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                    ext_f_prediction(ToeOff_index).Visual(2,1) = ext_f_prediction(ToeOff_index - 1).Visual(2,1) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                    ext_f_prediction(ToeOff_index).Visual(3,1) = ext_f_prediction(ToeOff_index - 1).Visual(3,1) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(1,2) = 0;     % rmx
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(2,2) = 0;     % rmy
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(3,2) = 0;     % rmz
                else
                    for swing_index = max(ToeOff_index,2):HeelStrike_index-1
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(1,1) = 0;     % rfx
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(2,1) = 0;     % rfy
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(3,1) = 0;     % rfz
    
                        ext_f_prediction(swing_index).Visual(1,1) = ext_f_prediction(swing_index - 1).Visual(1,1) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                        ext_f_prediction(swing_index).Visual(2,1) = ext_f_prediction(swing_index - 1).Visual(2,1) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                        ext_f_prediction(swing_index).Visual(3,1) = ext_f_prediction(swing_index - 1).Visual(3,1) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(1,2) = 0;     % rmx
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(2,2) = 0;     % rmy
                        ext_f_prediction(swing_index).fext(r_foot_index).fext(3,2) = 0;     % rmz
                    end
                end
            end
        end       
    end
    disp('  Right foot done');
    
    % Left foot
    disp('  Left foot...');
    % 1st frame
    if ext_f_prediction(1).fext(l_foot_index).fext(3,1) < threshold
        ext_f_prediction(1).fext(l_foot_index).fext(1,1) = 0;     % rfx
        ext_f_prediction(1).fext(l_foot_index).fext(2,1) = 0;     % rfy
        ext_f_prediction(1).fext(l_foot_index).fext(3,1) = 0;     % rfz
    
        ext_f_prediction(1).Visual(1,2) = ext_f_prediction(2).Visual(1,2);     % rpx
        ext_f_prediction(1).Visual(2,2) = ext_f_prediction(2).Visual(2,2);     % rpy
        ext_f_prediction(1).Visual(3,2) = ext_f_prediction(2).Visual(3,2);     % rpz
    
        ext_f_prediction(1).fext(l_foot_index).fext(1,2) = 0;     % rmx
        ext_f_prediction(1).fext(l_foot_index).fext(2,2) = 0;     % rmy
        ext_f_prediction(1).fext(l_foot_index).fext(3,2) = 0;     % rmz
    end
    
    % General case
    for frame_index = 2:frames_number
        if ext_f_prediction(frame_index).fext(l_foot_index).fext(3,1) < threshold
            if ext_f_prediction(frame_index-1).fext(l_foot_index).fext(3,1) > threshold
                % Toe Off found
                ToeOff_index = frame_index;
    
                rpx_start = ext_f_prediction(ToeOff_index).Visual(1,2);
                rpy_start = ext_f_prediction(ToeOff_index).Visual(2,2);
                rpz_start = ext_f_prediction(ToeOff_index).Visual(3,2);
            end
            if frame_index == frames_number
                % Heel Strike found
                HeelStrike_index = frame_index;
    
                rpx_end = ext_f_prediction(HeelStrike_index).Visual(1,2);
                rpy_end = ext_f_prediction(HeelStrike_index).Visual(2,2);
                rpz_end = ext_f_prediction(HeelStrike_index).Visual(3,2); 
    
                if ToeOff_index == HeelStrike_index
                    % Anomaly case
                    warning(['at frame ' num2str(frame_index) ' : swing phases should be longer than a single frame.'])
    
                    ext_f_prediction(ToeOff_index).fext(r_foot_index).fext(1,1) = 0;     % rfx
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(2,1) = 0;     % rfy
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(3,1) = 0;     % rfz
    
                    ext_f_prediction(ToeOff_index).Visual(1,2) = ext_f_prediction(ToeOff_index - 1).Visual(1,2) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                    ext_f_prediction(ToeOff_index).Visual(2,2) = ext_f_prediction(ToeOff_index - 1).Visual(2,2) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                    ext_f_prediction(ToeOff_index).Visual(3,2) = ext_f_prediction(ToeOff_index - 1).Visual(3,2) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(1,2) = 0;     % rmx
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(2,2) = 0;     % rmy
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(3,2) = 0;     % rmz
                else
                    for swing_index = max(ToeOff_index,2):HeelStrike_index-1
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(1,1) = 0;     % rfx
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(2,1) = 0;     % rfy
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(3,1) = 0;     % rfz
    
                        ext_f_prediction(swing_index).Visual(1,2) = ext_f_prediction(swing_index - 1).Visual(1,2) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                        ext_f_prediction(swing_index).Visual(2,2) = ext_f_prediction(swing_index - 1).Visual(2,2) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                        ext_f_prediction(swing_index).Visual(3,2) = ext_f_prediction(swing_index - 1).Visual(3,2) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(1,2) = 0;     % rmx
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(2,2) = 0;     % rmy
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(3,2) = 0;     % rmz
                    end
                end
            end
        else 
            if ext_f_prediction(frame_index-1).fext(l_foot_index).fext(3,1) < threshold
                % Heel Strike found
                HeelStrike_index = frame_index;
    
                rpx_end = ext_f_prediction(HeelStrike_index).Visual(1,2);
                rpy_end = ext_f_prediction(HeelStrike_index).Visual(2,2);
                rpz_end = ext_f_prediction(HeelStrike_index).Visual(3,2);
    
                % Rewrite swingphase
                if ToeOff_index == HeelStrike_index
                    % Anomaly case
                    warning(['at frame ' num2str(frame_index) ' : swing phases should be longer than a single frame.'])
    
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(1,1) = 0;     % rfx
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(2,1) = 0;     % rfy
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(3,1) = 0;     % rfz
    
                    ext_f_prediction(ToeOff_index).Visual(1,2) = ext_f_prediction(ToeOff_index - 1).Visual(1,2) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                    ext_f_prediction(ToeOff_index).Visual(2,2) = ext_f_prediction(ToeOff_index - 1).Visual(2,2) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                    ext_f_prediction(ToeOff_index).Visual(3,2) = ext_f_prediction(ToeOff_index - 1).Visual(3,2) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(1,2) = 0;     % rmx
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(2,2) = 0;     % rmy
                    ext_f_prediction(ToeOff_index).fext(l_foot_index).fext(3,2) = 0;     % rmz
                else
                    for swing_index = max(ToeOff_index,2):HeelStrike_index-1
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(1,1) = 0;     % rfx
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(2,1) = 0;     % rfy
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(3,1) = 0;     % rfz
    
                        ext_f_prediction(swing_index).Visual(1,2) = ext_f_prediction(swing_index - 1).Visual(1,2) + (rpx_end-rpx_start)/(HeelStrike_index-ToeOff_index);     % rpx
                        ext_f_prediction(swing_index).Visual(2,2) = ext_f_prediction(swing_index - 1).Visual(2,2) + (rpy_end-rpy_start)/(HeelStrike_index-ToeOff_index);     % rpy
                        ext_f_prediction(swing_index).Visual(3,2) = ext_f_prediction(swing_index - 1).Visual(3,2) + (rpz_end-rpz_start)/(HeelStrike_index-ToeOff_index);     % rpz
    
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(1,2) = 0;     % rmx
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(2,2) = 0;     % rmy
                        ext_f_prediction(swing_index).fext(l_foot_index).fext(3,2) = 0;     % rmz
                    end
                end
            end
        end       
    end
    disp('  Left foot done');
    
    disp('Filtering data -------------------------------------------- done');
    disp(' ');
end %end if filterData


%% Store to TimeSeriesTable
if convertToMot
    experimental_data_path = fullfile(data_dir, 'ExperimentalData.mat');
    experimental_data = load(experimental_data_path);

    first_time = experimental_data.ExperimentalData.Time(1);
    last_time = experimental_data.ExperimentalData.Time(end);
    step = (last_time - first_time)/experimental_data.ExperimentalData.LastFrame;
    time = first_time;
    time_vector = StdVectorDouble();
    
    labels = StdVectorString(['time']);
    labels.add('ground_force_vx');
    labels.add('ground_force_vy');
    labels.add('ground_force_vz');
    labels.add('ground_force_px');
    labels.add('ground_force_py');
    labels.add('ground_force_pz');
    labels.add('l_ground_force_vx');
    labels.add('l_ground_force_vy');
    labels.add('l_ground_force_vz');
    labels.add('l_ground_force_px');
    labels.add('l_ground_force_py');
    labels.add('l_ground_force_pz');
    labels.add('ground_torque_x');
    labels.add('ground_torque_y');
    labels.add('ground_torque_z');
    labels.add('l_ground_torque_x');
    labels.add('l_ground_torque_y');
    labels.add('l_ground_torque_z');
    
    
    rfx = StdVectorDouble();
    rfy = StdVectorDouble();
    rfz = StdVectorDouble();
    rpx = StdVectorDouble();
    rpy = StdVectorDouble();
    rpz = StdVectorDouble();
    lfx = StdVectorDouble();
    lfy = StdVectorDouble();
    lfz = StdVectorDouble();
    lpx = StdVectorDouble();
    lpy = StdVectorDouble();
    lpz = StdVectorDouble();
    rmx = StdVectorDouble();
    rmy = StdVectorDouble();
    rmz = StdVectorDouble();
    lmx = StdVectorDouble();
    lmy = StdVectorDouble();
    lmz = StdVectorDouble();
    
    
    %% Convert to the right units
    % OpenSim files : in m
    % CusToM files : in m
    convert_coeff = 1;
    
    
    %% Extract GRF data
    for frame_index = 1:frames_number
        % Time
        time_vector.add(time);
        time = time + step;
    
        % right foot
        rfx.add(ext_f_prediction(frame_index).fext(r_foot_index).fext(1,1));
        rfy.add(ext_f_prediction(frame_index).fext(r_foot_index).fext(2,1));
        rfz.add(ext_f_prediction(frame_index).fext(r_foot_index).fext(3,1));
        rpx.add(ext_f_prediction(frame_index).Visual(1,1) / convert_coeff);
        rpy.add(ext_f_prediction(frame_index).Visual(2,1) / convert_coeff);
        rpz.add(ext_f_prediction(frame_index).Visual(3,1) / convert_coeff);
        rmx.add(ext_f_prediction(frame_index).fext(r_foot_index).fext(1,2) / convert_coeff);
        rmy.add(ext_f_prediction(frame_index).fext(r_foot_index).fext(2,2) / convert_coeff);
        rmz.add(ext_f_prediction(frame_index).fext(r_foot_index).fext(3,2) / convert_coeff);
    
        % left foot
        lfx.add(ext_f_prediction(frame_index).fext(l_foot_index).fext(1,1));
        lfy.add(ext_f_prediction(frame_index).fext(l_foot_index).fext(2,1));
        lfz.add(ext_f_prediction(frame_index).fext(l_foot_index).fext(3,1));
        lpx.add(ext_f_prediction(frame_index).Visual(1,2) / convert_coeff);
        lpy.add(ext_f_prediction(frame_index).Visual(2,2) / convert_coeff);
        lpz.add(ext_f_prediction(frame_index).Visual(3,2) / convert_coeff);
        lmx.add(ext_f_prediction(frame_index).fext(l_foot_index).fext(1,2) / convert_coeff);
        lmy.add(ext_f_prediction(frame_index).fext(l_foot_index).fext(2,2) / convert_coeff);
        lmz.add(ext_f_prediction(frame_index).fext(l_foot_index).fext(3,2) / convert_coeff);
    
    end
    
    
    %% Write data in table
    GRF_table = TimeSeriesTable(time_vector);
    
    GRF_table.appendColumn(labels.get(1), Vector(rfx));
    GRF_table.appendColumn(labels.get(2), Vector(rfy));
    GRF_table.appendColumn(labels.get(3), Vector(rfz));
    GRF_table.appendColumn(labels.get(4), Vector(rpx));
    GRF_table.appendColumn(labels.get(5), Vector(rpy));
    GRF_table.appendColumn(labels.get(6), Vector(rpz));
    GRF_table.appendColumn(labels.get(7), Vector(lfx));
    GRF_table.appendColumn(labels.get(8), Vector(lfy));
    GRF_table.appendColumn(labels.get(9), Vector(lfz));
    GRF_table.appendColumn(labels.get(10), Vector(lpx));
    GRF_table.appendColumn(labels.get(11), Vector(lpy));
    GRF_table.appendColumn(labels.get(12), Vector(lpz));
    GRF_table.appendColumn(labels.get(13), Vector(rmx));
    GRF_table.appendColumn(labels.get(14), Vector(rmy));
    GRF_table.appendColumn(labels.get(15), Vector(rmz));
    GRF_table.appendColumn(labels.get(16), Vector(lmx));
    GRF_table.appendColumn(labels.get(17), Vector(lmy));
    GRF_table.appendColumn(labels.get(18), Vector(lmz));
    
    
    %% Rotate table
    % CusToM : z = upwards 
    % OpenSim : y = upwards
    rotate_table(GRF_table,'x',-90);
    
    
    %% Write mot file
    % Write Meta Data
    data_dir_parts = strsplit(data_dir,'\');
    output_name = [char(data_dir_parts(end-1)) '_predicted_grf.mot'];
    GRF_table.addTableMetaDataString('header',output_name);
    GRF_table.addTableMetaDataString('nColumns',num2str(GRF_table.getNumColumns()));
    GRF_table.addTableMetaDataString('nRows',num2str(GRF_table.getNumRows()));
    GRF_table.addTableMetaDataString('inDegrees','yes');
    
    % Write file
    disp('Writing data ---------------------------------------------- ...');
    output_path = fullfile(data_dir, '..',output_name);
    STOFileAdapter().write(GRF_table,output_path);
    disp('Writing data ---------------------------------------------- done');
    disp(' ');
    
    % Delete filtered table
    delete(filtered_data_path);

end %end if convertToMot

%% Functions

function rotate_table(table, axisString, angle)
    % Function to rotate data for consistency between file formats
    % CusToM : z = upwards 
    % OpenSim : y = upwards
    
    arguments
        table               % OpenSim TimeSeriesTableVec3 object
        axisString          {string}
        angle               {double}
    end
    
    disp('Rotating data --------------------------------------------- ...');

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
    % Rewrite in Matlab structure
    R = [R.get(0,0) , R.get(0,1) , R.get(0,2) ;...
         R.get(1,0) , R.get(1,1) , R.get(1,2) ;...
         R.get(2,0) , R.get(2,1) , R.get(2,2)];
    
    % Get labels
    labels = table.getColumnLabels();

    % Rotation() works on each row.
    for row_index = 0 : table.getNumRows() - 1
        % disp(['    Row ', num2str(row_index + 1), ' / ', num2str(table.getNumRows())]);
        row_rotated = StdVectorDouble();

        for label_index = 0 : 3 : table.getNumColumns()-1
            label_x = char(labels.get(label_index));
            label_y = char(labels.get(label_index + 1));
            label_z = char(labels.get(label_index + 2));

            if label_x(1:length(label_x)-1) == label_y(1:length(label_y)-1) & label_x(1:length(label_x)-1) == label_z(1:length(label_z)-1)
                % get a row from the table
                column_x = table.getDependentColumnAtIndex(label_index);
                column_y = table.getDependentColumnAtIndex(label_index + 1);
                column_z = table.getDependentColumnAtIndex(label_index + 2);

                vec = [column_x.get(row_index); column_y.get(row_index); column_z.get(row_index)];
                
                % Rotate vector
                vec_rotated = R * vec;
                
                % Write vector in row
                row_rotated.add(vec_rotated(1));
                row_rotated.add(vec_rotated(2));
                row_rotated.add(vec_rotated(3));

            else
                error('Label names are not three dimensions of the same vector')
            end
        end
        % overwrite vecor in row with rotated vector
        table.setRowAtIndex(row_index,RowVector(row_rotated));
    end
    disp('Rotating data --------------------------------------------- done');
    disp(' ')
end

function threshold = get_threshold_by_force_max(grf_data_path)
    arguments
        grf_data_path           {mustBeTextScalar}      % Path to the grf calculated by CusToM
    end

    disp('  Scaling threshold to max vertical force');
    load(grf_data_path);
    
    normal_forces = [];
    for index = 1:length(ExternalForcesComputationResults.ExternalForcesPrediction)
        normal_forces = [normal_forces ExternalForcesComputationResults.ExternalForcesPrediction(index).Visual(6,1) ...
                 ExternalForcesComputationResults.ExternalForcesPrediction(index).Visual(6,2)];
    end

   max_force = max(normal_forces);
   % Threshold for 1.80m and 72.6kg model (corresponding to a 748N max
   % vertical force) determined experimentaly at 10N.
   relative_threshold = 10/748;
   threshold = max_force * relative_threshold;
   disp(['  threshold = ' num2str(threshold)]);
end

function body_index =  get_body_index(body_name)
    arguments
        body_name           {string}
    end
    load("BiomechanicalModel.mat");
    model = BiomechanicalModel.OsteoArticularModel;
    body_index = 0;
    for index = 1:length(model)
        if strcmp(model(index).name,body_name)
            body_index = index;
        end
    end

    if body_index == 0
        error('Body was not found in model. Please check for spelling mistakes.')
    end

    disp([body_name ' = ' num2str(body_index)])
end

function k = get_scaling_factor_by_mass()
    disp('  Scaling threshold by mass ration');
    load 'BiomechanicalModel.mat'
    model = BiomechanicalModel.OsteoArticularModel;
    
    mass = 0;
    for body_index = 1:length(model)
        mass = mass + model(body_index).m;
    end
    mass
    k = mass/67.3109;
end

function k = get_scaling_factor_by_force_avg()
    disp('  Scaling threshold by mean vertical force ratio');
    load 'generated_markers/ExternalForcesComputationResults.mat'
    
    normal_forces = [];
    for index = 1:length(ExternalForcesComputationResults.ExternalForcesPrediction)
        normal_forces = [normal_forces ExternalForcesComputationResults.ExternalForcesPrediction(index).Visual(6,1) ...
                 ExternalForcesComputationResults.ExternalForcesPrediction(index).Visual(6,2)];
    end

   mean_force = mean(normal_forces)
   % Divide by mean_force for the 72.6kg reference model : 329.7436N
   k = mean_force / 329.7436;
end
