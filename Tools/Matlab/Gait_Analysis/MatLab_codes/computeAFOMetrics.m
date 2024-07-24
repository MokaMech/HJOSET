% Use this code to compute the approximate trappezoidal area under the 2
% Backpack-model and AFO-Backpack-model right and left ankle torque curves
clc
clear all

%% Import Data
[res1,path1] = uigetfile('*',"AFO_CMC : Select the 'ankle_musc_moments' file");
[res2,path2] = uigetfile('*',"BackP_RRA : Select the 'Actuation_force' file",path1); 
[res3,path3] = uigetfile('*',"noLoad_RRA : Select the 'Actuation_force' file",path1);

AFO_musc_moments = importCMCAnkleMuscMoments([path1,res1]);
AFO_r_ank_moments = [AFO_musc_moments(:,[1 3])];
AFO_l_ank_moments = [AFO_musc_moments(:,[1 2])];

Backpack_ank_moments = importRRAAnkleTorques([path2,res2]);
BP_r_ank_moments = [Backpack_ank_moments(:,[1 2])];
BP_l_ank_moments = [Backpack_ank_moments(:,[1 3])];

noLoad_ank_moments = importNoLoadRRAAnkleTorques([path3,res3]);
NL_r_ank_moments = [noLoad_ank_moments(:,[1 2])];
NL_l_ank_moments = [noLoad_ank_moments(:,[1 3])];



%% Plot curves
fig = figure();
fig.Position = [100 100 800 550];  
lineW = 1.3;

plot(NL_l_ank_moments(:,1),NL_l_ank_moments(:,2),'-b','LineWidth',lineW);
hold on;
plot(NL_r_ank_moments(:,1),NL_r_ank_moments(:,2),'-r','LineWidth',lineW);
hold on;
plot(BP_l_ank_moments(:,1),BP_l_ank_moments(:,2),'--b','LineWidth',lineW);
hold on;
plot(BP_r_ank_moments(:,1),BP_r_ank_moments(:,2),'--r','LineWidth',lineW);
hold on;
plot(AFO_l_ank_moments(:,1),AFO_l_ank_moments(:,2),'--ob',...
     'MarkerIndices',1:25:length(AFO_l_ank_moments(:,2)),...
     'LineWidth',lineW);
%area(AFO_l_ank_moments(:,1),AFO_l_ank_moments(:,2),'FaceAlpha',0.15,'LineStyle','-');
hold on;
plot(AFO_r_ank_moments(:,1),AFO_r_ank_moments(:,2),'--or',...
    'MarkerIndices',1:25:length(AFO_r_ank_moments(:,2)),...
    'LineWidth',lineW);
%area(AFO_r_ank_moments(:,1),AFO_r_ank_moments(:,2),['FaceAlpha'],0.15,'LineStyle','-');
title('GIL11-slow Ankle muscular torque generation');
xlabel("Time (sec)");
ylabel("Ankle muscle torque (Nm)");
legend('NoLoad-left','NoLoad-right','Backpack-left','Backpack-right','Backpack+AFO-left','Backpack+AFO-right',...
    'Position',[0.158550806241593 0.148905265673528 0.194764652559095 0.195312504361315]);
%%
%Compute integrals
BP_l_interg = trapz(BP_l_ank_moments);
BP_r_interg = trapz(BP_r_ank_moments);
AFO_l_interg = trapz(AFO_l_ank_moments);
AFO_r_interg = trapz(AFO_r_ank_moments);

disp("======= Integrals =======")
disp(strcat("BP_L : ",num2str(BP_l_interg(2)),...
            " | BP_R : ",num2str(BP_r_interg(2))));
disp(strcat("AFO_L : ",num2str(AFO_l_interg(2)),...
            " | AFO_R : ",num2str(AFO_r_interg(2))));

%% Compute metrics (peak difference and % of redux)

%Peaks differences
disp("======= Peak savings =======")
m1 = min(BP_l_ank_moments(:,2));
m2 = min(BP_r_ank_moments(:,2));
m3 = min(AFO_l_ank_moments(:,2));
m4 = min(AFO_r_ank_moments(:,2));

peak_l_save = m3 - m1;
peak_l_save_pourc = (peak_l_save / m1)*100;
peak_r_save = m4 - m2;
peak_r_save_pourc = (peak_r_save / m2)*100;
peak_mean = mean([peak_l_save peak_r_save]);
peak_pourc_mean = mean([peak_l_save_pourc peak_r_save_pourc]);

disp(strcat("Left : ",num2str(peak_l_save),...
            " Nm | ",num2str(peak_l_save_pourc)," %"));
disp(strcat("Right : ",num2str(peak_r_save),...
            " Nm | ",num2str(peak_r_save_pourc)," %"));
disp(strcat("- Mean - : ",num2str(peak_mean),...
            " Nm | ",num2str(peak_pourc_mean)," %"));

% Average muscle activity redux
disp("======= Avg. musc. activity redux =======")
    % Matching time series to fit the smaller one.
    if size(AFO_r_ank_moments,1) < size(BP_r_ank_moments,1)
        BP_r_ank_moments = interp1(BP_r_ank_moments(:,1),BP_r_ank_moments(:,1:2),AFO_r_ank_moments(:,1));
        BP_l_ank_moments = interp1(BP_l_ank_moments(:,1),BP_l_ank_moments(:,1:2),AFO_l_ank_moments(:,1));
    else
        AFO_r_ank_moments = interp1(AFO_r_ank_moments(:,1),AFO_r_ank_moments(:,1:2),BP_r_ank_moments(:,1));
        AFO_l_ank_moments = interp1(AFO_l_ank_moments(:,1),AFO_l_ank_moments(:,1:2),BP_l_ank_moments(:,1));
    end

% avgRdx_r = ((BP_r_interg - AFO_r_interg)/BP_r_interg)*100
% avgRdx_l = ((BP_l_interg - AFO_l_interg)/BP_l_interg)*100
res = trapz(AFO_r_ank_moments - BP_r_ank_moments );
avgRdx_r = (res(2)/BP_r_interg(2))*100;
res = trapz(AFO_l_ank_moments - BP_l_ank_moments);
avgRdx_l = (res(2)/BP_l_interg(2))*100;
Rdx_mean = mean([avgRdx_l avgRdx_r]);

disp(strcat("Left : ",num2str(avgRdx_l)," %"," | ","Right : ",num2str(avgRdx_r)," %"));
disp(strcat("- Mean - : ",num2str(Rdx_mean)," %"));

%% Compute RMSE error
% compute the RMSE error between the unscaled assistance model 
% (units normalized by subject mass) and the noLoad torque generation.
% this metric gives an idea of how "good or bad" the mechansism design
% (springs count and stiffness, motor control ... ) fits the original
% unloaded torque generation curve.

[res4,path4] = uigetfile('.mat',"AFO_modelError : Select the 'mechanism_error' mat file","..\Data");

load(strcat(path4,res4))
AFO_left_error = Model_error(:,[1 2]);
AFO_right_error = Model_error(:,[1 3]); 
rmse_error = (sqrt(mean(AFO_left_error(:,2).^2)) + sqrt(mean(AFO_right_error(:,2).^2)))/2

figure();
plot(AFO_left_error(:,1),AFO_left_error(:,2));
hold on;
plot(AFO_right_error(:,1),AFO_right_error(:,2));
hold on;
xlabel("time(sec)");
ylabel("Torque generation error Nm/kg")
title('Mechanism torque generation error');
legend("leftLeg-modelError","rightLef-modelError",...
    'Position',[0.608550806241593 0.148905265673528 0.194764652559095 0.125312504361315]);