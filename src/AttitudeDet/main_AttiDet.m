function [Attitude, AttiQuaternion] = main_AttiDet(ImageVector,CatalogVector)
%MAIN_ATTIDET
% 자세결정 Main함수

% [AttiQuaternion2] = QUEST_algo2(ImageVector,CatalogVector);
[AttiQuaternion] = QUEST_algo(ImageVector,CatalogVector);
[CeleAngle] = Quaternion2Cele(AttiQuaternion);
           
Attitude = CeleAngle;
end

