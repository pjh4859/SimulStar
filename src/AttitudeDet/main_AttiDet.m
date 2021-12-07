function [AttiQuaternion] = main_AttiDet(ImageVector,CatalogVector)
%MAIN_ATTIDET
% 자세결정 Main함수

% Determine where your m-file's folder is.
folder = fileparts(which('main_AttiDet.m')); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));

AttiQuaternion = inputArg2;
end

