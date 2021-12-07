function [ImageVector,CatalogVector] = MakeSelectedStarVector(StarCenter,BSCatalog,DeterminedStarMap,Params)
%MAKESELECTEDSTARVECTOR
%   선택된 트라이앵글 혹은 피라미드 별들의 실제 벡터와, 이미지 센서상에서의 벡터를 반환.

[~,cols] = size(DeterminedStarMap);
CatalogVector = [];
ImageVector = [];
for i=1:(cols/2)
    RA = BSCatalog(i,2);
    DEC = BSCatalog(i,3);
    [x,y,z] = sph2cart(RA*pi/180, DEC*pi/180,1);
    CatalogVector = [CatalogVector; x,y,z];
    
    tempVector = CalVector(DeterminedStarMap(1,i),StarCenter,Params);
    ImageVector = [ImageVector; tempVector];
end                     
end

