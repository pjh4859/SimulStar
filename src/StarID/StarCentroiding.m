function [OutCenter] = StarCentroiding(StarMat,Labels,StarNum)
%STARCENTROIDING 
%   라벨링에 의해 하나의 별이라고 인식된 것의 중심점을 찾는 함수.

OutCenter = [];
% 탐색된 별의 갯수만큼 for 문 돌림
for i = 1:StarNum
%     라벨 번호가 i 인 픽셀들의 index를 구함.
    [row, col] = find(Labels == i);
    RowMin = min(row);
    RowMax = max(row);
    ColMin = min(col);
    ColMax = max(col);
%     구한 인덱스를 통해 이 별의 형태가 들어가는 정사각 배열을 만듬.
    tempArr = zeros(RowMax-RowMin+1, ColMax-ColMin+1);
%     선택된 라벨의 픽셀 갯수를 구함.
    pixNum = numel(find(Labels==i));
%     픽셀 갯수만큼 포문을 돌림.
    for j = 1:pixNum
%         임시 배열에 해당 라벨 별의 실제 픽셀 값을 집어넣음.
        tempArr(row(j)-RowMin+1, col(j)-ColMin+1) = StarMat(row(j),col(j));
    end
%     웨이트 센트로이딩을 구함.
Center(i) = regionprops(true(size(tempArr)), tempArr, 'WeightedCentroid');
% 아웃풋으로 별마다 중심 좌표를 원래 배열의 위치로 찍음.
OutCenter(i,:) = [Center(i).WeightedCentroid(1) + ColMin - 1, Center(i).WeightedCentroid(2) + RowMin - 1];

end

end

