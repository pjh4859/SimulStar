function [StarCandi1,StarCandi2,StarCandi3] = FindTriangleCandi(Kvector,StarPairAngle,a1,a0)
%FindTriangle
%  세 각으로 삼각형 후보군을 찾는 함수.

StarCandi1 = [];
StarCandi2 = [];
StarCandi3 = [];

% 센트로이딩 오차 + 별별오차
% 10 arcsec by Mortari,1997
epsilon = 10/3600;
for i=1:size(StarPairAngle,1) %Size must be 3;
    Lbot = floor((cosd(StarPairAngle(i,1) + 2*epsilon) - a0)/a1);
    Ltop = ceil((cosd(StarPairAngle(i,1) - 2*epsilon) - a0)/a1);
    Kstart = Kvector(Lbot,1)+1;
    Kend = Kvector(Ltop,1);
    switch i
        case 1
%             StarCandi1 = Kvector(Kvector >= Kstart & Kvector <= Kend,:);
            StarCandi1 = Kvector(Kstart:Kend,:);
        case 2
%             StarCandi2 = Kvector(Kvector >= Kstart & Kvector <= Kend,:);
            StarCandi2 = Kvector(Kstart:Kend,:);
        case 3
%             StarCandi3 = Kvector(Kvector >= Kstart & Kvector <= Kend,:);
            StarCandi3 = Kvector(Kstart:Kend,:);
    end
end

end

