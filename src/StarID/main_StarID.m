function [outputArg1] = main_StarID(StarMat, Threshold, UIAxes, Params)
%MAIN_STARID
%   별 인식 알고리즘의 메인 함수.
% Determine where your m-file's folder is.
folder = fileparts(which('main_StarID.m')); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));

ThresholdMag = 5;
% FoVx = 5;
% FoVy = 5;

% 별 라벨링
[Labels, StarNum] = RegionLabeling(StarMat, Threshold);

% 라벨링된 별들을 가지고 중심점을 구함.
[StarCenter] = StarCentroiding(StarMat,Labels,StarNum);

% 별 중심 고른 것을 UI 에 보여줌.
MakeStarCenterImage(UIAxes, StarCenter);

% Kvector 를 만들기 위한 함수로 이미 있다면 하는 기능은 없음.
% Make_Svector(Parmas.FoVx, Params.FoVy, ThresholdMag);

% k벡터, 별 카탈로그, a0,a1 값 txt 파일을 읽음.
[BSCatalog, Kvector, a1, a0] = ReadFiles(Params.FoVx, Params.FoVy, ThresholdMag);

% 파라미터 스트럭쳐에 a1, a0 추가.
Params.a1 = a1;
Params.a0 = a0;

% 이제 별들의 중심점들 가지고 별 페어의 각도를 구하며, 피라미드 알고리즘 구동.
[DeterminedStarMap] = PyramidAlgo(Kvector, StarCenter, Params);
end

