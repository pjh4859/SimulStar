function [LabeledMatrix] = RegionLabeling(StarMat, PixX, PixY, Threshold)
%REGIONLABELING 
%  별 이미지 매트릭스에서 스레스홀드 이상의 밝기를 가진 별들만 라벨링해서 새로운 배열을 만든다.

% 넘버링될 별 라벨 번호.
StarNum = 1;
% padding을 위해 들어온 매트릭스 크기보다 가로, 세로 2씩 더 큰 zero 배열을 만든다.
tempMatrix = zeros(PixY+2, PixX+2);
% 위에서 만든 zero 배열 가운데에 원래 매트릭스를 넣는다.
tempMatrix(2:PixY + 2 - 1, 2:PixX + 2 - 1) = StarMat;

for i = 1:PixY
    for j = 1:PixX
        if tempMatrix(1+i, 1+j) >= Threshold
            if tempMatrix(1+i, 1+j)

            end

        end

    end
end

end
