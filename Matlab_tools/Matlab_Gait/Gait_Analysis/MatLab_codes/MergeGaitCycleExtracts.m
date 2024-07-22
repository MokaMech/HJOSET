clc
clear all

%% Import Data (Modify this depending on your files)
ankleKinData = [GIL11free1backpackRRAKinematicsq.time GIL11free1backpackRRAKinematicsq.ankle_angle_l GIL11free1backpackRRAKinematicsq.ankle_angle_r];
ankleMomData = [GIL11free1backpackRRAActuationforce.time GIL11free1backpackRRAActuationforce.ankle_angle_l_reserve GIL11free1backpackRRAActuationforce.ankle_angle_r_reserve];

%% Plot Data to check
plot(ankleKinData(:,2),ankleMomData(:,2));
hold on
plot(ankleKinData(:,3),ankleMomData(:,3));

%% Interp Data to match timestamps
ankleKinData = interp1(ankleKinData(:,1),ankleKinData(:,1:3),ankleMomData(:,1));

%% Compute Intersection
rightLeg = [ankleKinData(:,2) ankleMomData(:,2)];
leftLeg = [ankleKinData(:,3) ankleMomData(:,3)];
P = InterX([rightLeg',leftLeg']); % P is the intersection of curves
plot(P(1,:),P(2,:),'ro');
hold on;
disp("Inter points : ")

%% Choose Inter Points to draw a cycle
PtoKeep = [P(:,1) P(:,16)];
plot(PtoKeep(1,:),PtoKeep(2,:),'gX');

%% Extract Data and cross-validate the new gait cycle.
stiffDataLeft = [ankleKinData(:,1:2) ankleMomData(:,2)];
stiffDataRight = [ankleKinData(:,1) ankleKinData(:,3) ankleMomData(:,3)];

[Lval,Lind1] = min(abs(stiffDataLeft(1:end,2:3)-PtoKeep(1,:)));
[Lval,Lind2] = min(abs(stiffDataLeft(1:end,2:3)-PtoKeep(2,:)));
[Rval,Rind1] = min(abs(stiffDataRight(1:end,[1 3])-PtoKeep(1,:)));
[Rval,Rind2] = min(abs(stiffDataRight(1:end,[1 3])-PtoKeep(2,:)));

kinToKeep  = ankleKinData(Lind1(1):Lind2(2),1:2);
kinToKeep2 = ankleKinData(Rind2(2):Rind1(2),[1 3]);
momToKeep  = ankleMomData(Lind1(1):Lind2(1),1:2);
momToKeep2 = ankleMomData(Rind2(2):Rind1(2),[1 3]);

figure;
plot(kinToKeep(:,2),momToKeep(:,2));
hold on;
plot(kinToKeep2(:,2),momToKeep2(:,2));

%% Last Step : Manual edition for accurate shape
stiffData = [[kinToKeep;kinToKeep2] [momToKeep(:,2);momToKeep2(:,2)]];
figure;
plot(stiffData(:,2),stiffData(:,2));
