function [outputCatalog] = SelectStars(inputCatalog,inputParam)
%Select_Star: 그림으로 표현할 영역 내에 존재하는 별을 추려내는 함수.
%   자세한 설명 위치
global Debugmode

% FoV들의 대각을 구하는 식: 피타고라스로 가정.
Radius = sqrt(inputParam.FoVx^2 + inputParam.FoVy^2)/2;
%     중심점 벡터 구하기.
%     CenterVector = Transform.Celestial2Cartesian(inputParam.RA,inputParam.DEC);
[x,y,z] = sph2cart(inputParam.RA*pi/180,inputParam.DEC*pi/180,1);
CenterVector = [x,y,z];

%   outputCatalog를 위한 변수.
n=uint32(1);
%   output 배열 생성.
outputCatalog = [];

for i=1:size(inputCatalog,1)
    RA_Star = inputCatalog(i,2);
    DEC_Star = inputCatalog(i,3);
    %       별의 벡터 구하기.
    %       StarVector = Transform.Celestial2Cartesian(RA_Star,DEC_Star);
    [x,y,z] = sph2cart(RA_Star*pi/180,DEC_Star*pi/180,1);
    StarVector = [x,y,z];
    %       중심점과 별 벡터 내적.
    Check = dot(CenterVector,StarVector);
    %       밝기 읽기.
    Magnitude = inputCatalog(i,4);

    %         밝기등급 제한
    if (Magnitude <= inputParam.MagLimit)
        %       내적을 이용해서 현재 확인하는 별 좌표가 우리가 원하는 범위 내에 있는지 확인.
        if (Check >= cosd(Radius))
            %             For Debuging
            %             if feature('IsDebugMode')
            if Debugmode
                fileID2 = fopen('../StarVector.txt','a');
                fprintf(fileID2,"%f %f %f\n",x,y,z);
                fclose(fileID2);
            end
            %             end
            outputCatalog(n,:) = inputCatalog(i,:);
            n = n+1;
        end
    end

    %       아무 별도 해당되지 않을 경우 예외처리.
    if (i == size(inputCatalog,1))
        if (~size(outputCatalog,1))
            outputCatalog = [NaN,NaN,NaN,NaN,NaN,NaN];
        end
    end

end
end

