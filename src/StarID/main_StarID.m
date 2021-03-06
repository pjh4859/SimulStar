function [SvectorFlag,Flag, Attitude, AttiQuaternion] = main_StarID(StarMat, PixThreshold, UIAxes, Params)
%MAIN_STARID
%   별 인식 알고리즘의 메인 함수.
% % Determine where your m-file's folder is.
% folder = fileparts(which('main_StarID.m')); 
% % Add that folder plus all subfolders to the path.
% addpath(genpath(folder));

Flag = 0;
AttiQuaternion = [nan, nan,nan,nan];
Attitude = struct('RA',nan,'DEC',nan,'ROT',nan);

% 별 라벨링 Input은 이미지 매트릭스(흑백 0~255), 픽셀의 밝기 스레스홀드.
[Labels, StarNum] = RegionLabeling(StarMat, PixThreshold);

% 라벨링된 별들을 가지고 중심점을 구함.
% 여기서 나온 StarCenter 배열의 Col index 는 별의 Label 번호와 같음.
[StarCenter] = StarCentroiding(StarMat,Labels,StarNum);

% 별 중심 고른 것을 UI 에 보여줌.
MakeStarCenterImage(UIAxes, StarCenter);

% Kvector 를 만들기 위한 함수로 이미 있다면 하는 기능은 없음.
[~,SvectorFlag] = Make_Svector(Params.FoVx, Params.FoVy, Params.ThresholdMag);

% k벡터, 별 카탈로그, a0,a1 값 txt 파일을 읽음.
[BSCatalog, Kvector, a1, a0] = ReadFiles(Params.FoVx, Params.FoVy, Params.ThresholdMag);

% 파라미터 스트럭쳐에 a1, a0 추가.
Params.a1 = double(a1);
Params.a0 = double(a0);

if (size(StarCenter,1) < 2)
    % 별이 적을때.
    
elseif (size(StarCenter,1) == 3)
    %별이 3개뿐일 때.
    [DeterminedStarMap,TriFlag] = TriangleAlgo(BSCatalog, Kvector, StarCenter, Params);
    if TriFlag
        MakeSelectedImage(UIAxes, StarCenter, DeterminedStarMap);
        Flag = 1;
    end
else
    % 이제 별들의 중심점들 가지고 별 페어의 각도를 구하며, 피라미드 알고리즘 구동.
    % DeterminedStarMap 의 형태 [라벨i, 라벨j, 라벨k, 라벨r, i인덱스, j인덱스, k인덱스, r인덱스]
    [DeterminedStarMap,PyrFlag] = PyramidAlgo(BSCatalog, Kvector, StarCenter, Params);
    if PyrFlag
        MakeSelectedImage(UIAxes, StarCenter, DeterminedStarMap);
        Flag = 1;
    else
        [DeterminedStarMap,TriFlag] = TriangleAlgo(BSCatalog, Kvector, StarCenter, Params);
        if TriFlag
            MakeSelectedImage(UIAxes, StarCenter, DeterminedStarMap);
            Flag = 1;
        end
    end
end

if Flag
    % ImageVector 와 CatalogVector 의 형상 [ x, y, z ; x2, y2, z2 ; ...]
    % 3개의 벡터 또는 4개의 벡터행을 가지고 있음.
    [ImageVector,CatalogVector] = MakeSelectedStarVector(StarCenter,BSCatalog,DeterminedStarMap,Params);
    [Attitude, AttiQuaternion] = main_AttiDet(ImageVector,CatalogVector);
end

end

