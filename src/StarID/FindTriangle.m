function [StarCandi1,StarCandi2,StarCandi3] = FindTriangle(Kvector,StarPairAngle,a1,a0)
%FindTriangle
%  세 각으로 삼각형 후보군을 찾는 함수.

StarCandi1 = [];
StarCandi2 = [];
StarCandi3 = [];

% 센트로이딩 오차 + 별별오차
% 10arcsec by Mortari,1997
epsilon = 10/3600;
for i=1:size(StarPairAngle,1) %Size must be 3;
    Lbot = floor((cosd(StarPairAngle(i) + 2*epsilon) - a0)/a1);
    Ltop = ceil((cosd(StarPairAngle(i) - 2*epsilon) - a0)/a1);
    Kstart = Kvector(Lbot)+1;
    Kend = Kvector(Ltop);
    switch i
        case 1
            StarCandi1 = Kvector(Kvector >= Kstart & Kvector <= Kend);
        case 2
            StarCandi2 = Kvector(Kvector >= Kstart & Kvector <= Kend);
        case 3
            StarCandi3 = Kvector(Kvector >= Kstart & Kvector <= Kend);
    end
end

end

