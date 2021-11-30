function [outputArg1] = main_StarID(StarMat, Threshold, UIAxes)
%MAIN_STARID
%   별 인식 알고리즘의 메인 함수.
% Determine where your m-file's folder is.
folder = fileparts(which('main_StarID.m')); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));

ThresholdMag = 5.5;
FoVx = 10;
FoVy = 10;

% 별 라벨링
[Labels, StarNum] = RegionLabeling(StarMat, Threshold);
% 라벨링된 별들을 가지고 중심점을 구함.
[StarCenter] = StarCentroiding(StarMat,Labels,StarNum);
% 별 중심 고른 것을 UI 에 보여줌.
MakeStarCenterImage(UIAxes, StarCenter);
% Kvector 를 만들기 위한 함수로 이미 있다면 하는 기능은 없음.
Make_Svector(FoVx, FoVy, ThresholdMag);
% k벡터, 별 카탈로그, a0,a1 값 txt 파일을 읽음
[BSCatalog, Kvector, a1, a0] = ReadFiles(FoVx, FoVy, ThresholdMag);
% 이제 별들의 중심점들 가지고 별 페어의 각도를 구하며, 피라미드 알고리즘 구동.

end

