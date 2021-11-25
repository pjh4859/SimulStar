function [outputArg1] = main_StarID(StarMat, Threshold, UIAxes)
%MAIN_STARID
%   별 인식 알고리즘의 메인 함수.


[Labels, StarNum] = RegionLabeling(StarMat, Threshold);
[StarCenter] = StarCentroiding(StarMat,Labels,StarNum);
MakeStarCenterImage(UIAxes, StarCenter);

end

