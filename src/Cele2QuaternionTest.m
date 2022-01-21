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

delQ = quatmultiply(ReferQ, quatinv(Quaternion));

ErrTheta = atan2(sqrt(delQ(:,2).*delQ(:,2) + delQ(:,3).*delQ(:,3) + delQ(:,4).*delQ(:,4)), delQ(:,1)); 
% theta = acos(delQ(:,1))*2;

ErrThetad = ErrTheta * 180/pi;

AverageErr = mean(ErrThetad, 'omitnan');

AverageErrArcsec = AverageErr * 3600;