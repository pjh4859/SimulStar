function [Vector] = CalVector(LabelNum,StarCenter,Params)
%CalVector
%   별의 중심좌표의 벡터를 구하는 함수.

% uint8 에서 double 형으로.
FoVx = double(Params.FoVx);
FoVy = double(Params.FoVy);
pixX = double(Params.pixX);
pixY = double(Params.pixY);

% 원형의 FoV를 구함.
FoV = sqrt((FoVx)^2+(FoVy)^2);
% Focal Length 를 구함
f = cosd(FoV/2);

% 각거리를 구할 두 별의 가상의 이미지 센서 상에서의 벡터를 구함.
% 중심은 가상의 이미지 센서의 중심.
Star = [StarCenter(LabelNum,1), StarCenter(LabelNum,2)];
StarVector = [(Star(1)-1-pixX/2)*2/pixX*f*tand(FoVx/2), (Star(2)-1-pixY/2)*2/pixY*f*tand(FoVy/2), f];

Vector = StarVector;
end