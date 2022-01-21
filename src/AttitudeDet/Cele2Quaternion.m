function [Quaternion] = Cele2Quaternion(CeleAngle)
%Cele2Quaternion
%   celestial coordinate 에서 quaternion 으로 변환

eulerAngles = [];

eulerAngles(:,1) = (CeleAngle(:,1) + 90);
eulerAngles(:,2) =  (- CeleAngle(:,2) + 90);
eulerAngles(:,3) =  (- CeleAngle(:,3) + 180);

for i=1:size(eulerAngles,1)
    if eulerAngles(i,1)>360
        eulerAngles(i,1) = eulerAngles(i,1) - 360;
    end
    if eulerAngles(i,3)>360
        eulerAngles(i,3) = eulerAngles(i,1) - 360;
    end
end

% eulerAngles(:,1) = (CeleAngle(:,1) + 90)*pi/180;
% eulerAngles(:,2) =  (- CeleAngle(:,2) + 90)*pi/180;
% eulerAngles(:,3) =  (- CeleAngle(:,3) + 180)*pi/180;

eulerAngles =  eulerAngles * pi/180;



Quaternion = eul2quatZXZ(eulerAngles, 'ZXZ');
% phi = inputParam.RA + 90;
% theta = 90 - inputParam.DEC;
% psi = - inputParam.ROT + 180;
end

