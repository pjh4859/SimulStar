function [CeleAngle] = Quaternion2Cele(AttiQuaternion)
%QUATERNION2CELE
%   자세결정알고리즘으로 얻은  quaternion 에서 celestial coordinate 로 변환
q = quaternion(AttiQuaternion);
eulerAngles = eulerd(q,'ZXZ','frame');

% phi = inputParam.RA + 90;
% theta = 90 - inputParam.DEC;
% psi = - inputParam.ROT + 180;


CeleAngle.RA = eulerAngles(1) - 90;
CeleAngle.DEC = - eulerAngles(2) + 90;
CeleAngle.ROT = - eulerAngles(3) + 180;
if CeleAngle.RA < 0 
    CeleAngle.RA = CeleAngle.RA + 360;
end
end

