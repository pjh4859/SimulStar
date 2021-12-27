function [Attitude] = main_AttiDet(ImageVector,CatalogVector)
%MAIN_ATTIDET
% 자세결정 Main함수

[AttiQuaternion] = QUEST_algo(ImageVector,CatalogVector);
end

