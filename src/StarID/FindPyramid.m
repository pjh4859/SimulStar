function [MatchPyramid, PyrFlag] = FindPyramid(MatchTri,Kvector,StarPairAngle,a1,a0,r)
%FINDPYRAMID
%   레퍼런스 스타 하나를 추가하여, 4개의 별로 StarIdentification 을 수행함.
StarCandi1 = [];
StarCandi2 = [];
StarCandi3 = [];
PyrFlag = 0;
MatchPyramid = [];
MatchR = [];

% 센트로이딩 오차 + 별별오차
% 10arcsec by Mortari,1997
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

for i=1:size(MatchTri,1)
[tempx,~] = find(StarCandi1 == MatchTri(i,4));
StarCandi1 = StarCandi1(tempx,:);
[tempx,~] = find(StarCandi2 == MatchTri(i,5));
StarCandi2 = StarCandi2(tempx,:);
[tempx,~] = find(StarCandi3 == MatchTri(i,6));
StarCandi3 = StarCandi3(tempx,:);

if (size(StarCandi1,1) && size(StarCandi2,1) && size(StarCandi3,1))
    rNum = intersect(intersect(StarCandi1,StarCandi2),StarCandi3);
    [Numrow,Numcol] = size(rNum);
    if Numrow == 1 && Numcol == 1
        MatchR = [MatchR; r, rNum, i];
    end
end

end
% reference Star 가 하나만 나오는지 체크.
if size(MatchR,1) == 1
    PyrFlag = 1;
    %[i j k r I J K R]모양으로 바꿈.
    MatchPyramid = [MatchTri(MatchR(1,3),1:3), MatchR(1,1), MatchTri(MatchR(1,3),4:6), MatchR(1,2)];
end
end

