function [OsteoArticularModel]= Leg_gait2354_TLEMContact(OsteoArticularModel,k,Signe,Mass,AttachmentPoint)
% Addition of a leg model
%   This leg model contains 3 solids (thigh, shank and foot),
%   exhibits 3 dof for the hip, 1 dof for the knee and 2 dof for the
%   ankle
%
%	Based on:
%	- Damsgaard, M., Rasmussen, J., Christensen, S. T., Surma, E., & De Zee, M., 2006.
% 	Analysis of musculoskeletal systems in the AnyBody Modeling System. Simulation Modelling Practice and Theory, 14(8), 1100-1111.
%
%   INPUT
%   - OsteoArticularModel: osteo-articular model of an already existing
%   model (see the Documentation for the structure)
%   - k: homothety coefficient for the geometrical parameters (defined as
%   the subject size in cm divided by 180)
%   - Signe: side of the leg model ('R' for right side or 'L' for left side)
%   - Mass: mass of the solids
%   - AttachmentPoint: name of the attachment point of the model on the
%   already existing model (character string)
%   OUTPUT
%   - OsteoArticularModel: new osteo-articular model (see the Documentation
%   for the structure) 
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________
[OsteoArticularModel]= Femur_gait2354(OsteoArticularModel,k,Signe,Mass,AttachmentPoint);
[OsteoArticularModel]= Tibia_gait2354(OsteoArticularModel,k,Signe,Mass,[Signe 'Thigh_KneeJointNode']);
[OsteoArticularModel]= talus_gait2354(OsteoArticularModel,k,Signe,Mass,[Signe 'Shank_TalocruralJointNode']);
[OsteoArticularModel]= calcn_gait2354_TLEMcontact(OsteoArticularModel,k,Signe,Mass,[Signe 'talus_calcJointNode']);
[OsteoArticularModel]= toes_gait2354(OsteoArticularModel,k,Signe,Mass,[Signe 'calcn_toeJointNode']);


end