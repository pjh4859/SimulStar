function [StarmapPosiMAT] = StarmapProjection(StarMatrix, inputPixel, inputParam, inputImage)
global randNum;
randNum = 0;
% 이미지 센서 상에 보여지게 될 별 이미지 매트릭스
StarmapPosiMAT(inputPixel.PixelNum_Y,inputPixel.PixelNum_X,3) = 0;
for i=1:size(StarMatrix,1)
    x = StarMatrix(i,1);
    y = StarMatrix(i,2);
    Star_Mag = StarMatrix(i,4);
   
    Radius = sqrt(inputParam.FoVx^2 + inputParam.FoVy^2)/2;
    Plane_x = round((inputPixel.PixelNum_X/2)/(cosd(Radius)*tand(inputParam.FoVx/2))*(x) + (inputPixel.PixelNum_X/2)) +1;
    Plane_y = round((inputPixel.PixelNum_Y/2)/(cosd(Radius)*tand(inputParam.FoVy/2))*(y) + (inputPixel.PixelNum_Y/2)) +1;
    StarmapPosition(i,:) = [Plane_x, Plane_y, Star_Mag];    
   
end
%%
% 랜덤미싱 파트
if inputImage.ActiveMissing == true
    randNum = randi([inputImage.MissingMin, inputImage.MissingMax]);
%     assignin('base','randNum',randNum);

    inputImage.MissingNum = randNum;
    if randNum > size(StarmapPosition,1)
        randNum = size(StarmapPosition,1);
    end
    for i=1:randNum
        StarmapPosition(randi([1, size(StarmapPosition,1)]),:) = [];
    end
end
% 모든 별이 사라졌을 때를 대비한 오류처리
if size(StarmapPosition,1) == 0 
    StarmapPosition(1,:) = [NaN,NaN,NaN];
end
%%

for i=1:size(StarmapPosition,1)
    Plane_x = StarmapPosition(i,1);
    Plane_y = StarmapPosition(i,2);
    Star_Mag = StarmapPosition(i,3);
    % 정해진픽셀 판 안에 들어오는 애들만 남김
    if (Plane_x <=inputPixel.PixelNum_X && Plane_x > 0 && Plane_y <= inputPixel.PixelNum_Y && Plane_y >0)
        % 블러가 활성되었을 때
        if inputImage.ActiveBlur == 1
            GreyValue = StarGrey_mag(inputImage,Star_Mag);
            % rgb 채널 3차원으로 만듦
            StarmapPosiMAT(Plane_y,Plane_x,1) = Utile.ConstrainUint16(StarmapPosiMAT(Plane_y,Plane_x,1), GreyValue);
            StarmapPosiMAT(Plane_y,Plane_x,2) = Utile.ConstrainUint16(StarmapPosiMAT(Plane_y,Plane_x,2), GreyValue);
            StarmapPosiMAT(Plane_y,Plane_x,3) = Utile.ConstrainUint16(StarmapPosiMAT(Plane_y,Plane_x,3), GreyValue);
        % 블러가 없으면 최대밝기
        else
            % rgb 채널 3차원으로 만듦
            StarmapPosiMAT(Plane_y,Plane_x) = 65535;
            StarmapPosiMAT(Plane_y,Plane_x,2) = 65535;
            StarmapPosiMAT(Plane_y,Plane_x,3) = 65535;
        end
    end
end

StarmapPosiMAT = cast(StarmapPosiMAT, 'uint16');
end