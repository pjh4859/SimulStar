function [OutAngle] = CalPix2Deg(FoVx,FoVy,pixX,pixY,Star1,Star2)
%CALPIX2DEG
%   픽셀간의 좌표에서 각을 구하는 함수.

% 원형의 FoV를 구함.
FoV = sqrt(FoVx^2+FoVy^2);

% Focal Length 를 구함
f = cosd(FoV/2);

% 각거리를 구할 두 별의 가상의 이미지 센서 상에서의 벡터를 구함.
% 중심은 가상의 이미지 센서의 중심.
Star1Vector = [(Star1(1)-1-pixX/2)*2/pixX*f*tand(FoVx/2), (Star1(2)-1-pixY/2)*2/pixY*f*tand(FoVy/2), f];
Star2Vector = [(Star2(1)-1-pixX/2)*2/pixX*f*tand(FoVx/2), (Star2(2)-1-pixY/2)*2/pixY*f*tand(FoVy/2), f];

% 두 벡터의 내적을 이용해 cos(theta) 를 구하고 그를 통해 Theta를 구함.
temp = dot(Star1Vector,Star2Vector);
temp = temp/(norm(Star1Vector) * norm(Star2Vector));
Degree = acosd(temp);

OutAngle = Degree;
end

