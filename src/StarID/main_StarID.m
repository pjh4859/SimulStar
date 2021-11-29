function [outputArg1] = main_StarID(StarMat, Threshold, UIAxes)
%MAIN_STARID
%   별 인식 알고리즘의 메인 함수.
% Determine where your m-file's folder is.
folder = fileparts(which('main_StarID.m')); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));

[Labels, StarNum] = RegionLabeling(StarMat, Threshold);
[StarCenter] = StarCentroiding(StarMat,Labels,StarNum);
MakeStarCenterImage(UIAxes, StarCenter);

end

