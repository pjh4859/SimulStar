function [MatchTri] = MatchTriangle(TriStar, BSCatalog, StarPairAngle)
%MATCHTRIANGLE
%   골라진 트라이앵글의 후보군의 각거리를 계산해서 라벨링된 이미지상의 별과 매칭시키는 함수.
MatchTri = [];
for i=1:size(TriStar,1)
    [x1,y1,z1] = sph2cart(BSCatalog(TriStar(i,1),2)*pi/180, BSCatalog(TriStar(i,1),3)*pi/180,1);% A
    [x2,y2,z2] = sph2cart(BSCatalog(TriStar(i,2),2)*pi/180, BSCatalog(TriStar(i,2),3)*pi/180,1);% B
    [x3,y3,z3] = sph2cart(BSCatalog(TriStar(i,3),2)*pi/180, BSCatalog(TriStar(i,3),3)*pi/180,1);% C

    StarVector1 = [x1,y1,z1];% A
    StarVector2 = [x2,y2,z2];% B
    StarVector3 = [x3,y3,z3];% C
    
    AB = dot(StarVector1,StarVector2);
    AC = dot(StarVector1,StarVector3);
    BC = dot(StarVector2,StarVector3);
    ABdegree = acosd(AB);
    ACdegree = acosd(AC);
    BCdegree = acosd(BC);

    ijdegree = StarPairAngle(1,1);
    ikdegree = StarPairAngle(2,1);
    jkdegree = StarPairAngle(3,1);
    tempArr = [ijdegree - ABdegree, ijdegree - ACdegree, ijdegree - BCdegree];
    ijStar = (abs(tempArr-0) == min(abs(tempArr-0)));
    tempArr = [jkdegree - ABdegree, jkdegree - ACdegree, jkdegree - BCdegree];
    jkStar = (abs(tempArr-0) == min(abs(tempArr-0)));

    if ijStar(1) == 1
        if jkStar(2) == 1
            % i=B, j=A, k=C
            MatchTri = [MatchTri; StarPairAngle(1,2),StarPairAngle(1,3),StarPairAngle(2,3),TriStar(i,2),TriStar(i,1),TriStar(i,3)];
        elseif jkStar(3) == 1
            % i=A, j=B, k=C
            MatchTri = [MatchTri; StarPairAngle(1,2),StarPairAngle(1,3),StarPairAngle(2,3),TriStar(i,1),TriStar(i,2),TriStar(i,3)];
        else
        end
        
    elseif ijStar(2) == 1
        if jkStar(1) == 1
            % i=C, j=A, k=B
            MatchTri = [MatchTri; StarPairAngle(1,2),StarPairAngle(1,3),StarPairAngle(2,3),TriStar(i,3),TriStar(i,1),TriStar(i,2)];
        elseif jkStar(3) == 1
            % i=A, j=C, k=B
            MatchTri = [MatchTri; StarPairAngle(1,2),StarPairAngle(1,3),StarPairAngle(2,3),TriStar(i,1),TriStar(i,3),TriStar(i,2)];
        else
        end

    elseif ijStar(3) == 1
        if jkStar(1) == 1
            % i=C, j=B, k=A
            MatchTri = [MatchTri; StarPairAngle(1,2),StarPairAngle(1,3),StarPairAngle(2,3),TriStar(i,3),TriStar(i,2),TriStar(i,1)];
        elseif jkStar(2) == 1
            % i=B, j=C, k=A
            MatchTri = [MatchTri; StarPairAngle(1,2),StarPairAngle(1,3),StarPairAngle(2,3),TriStar(i,2),TriStar(i,3),TriStar(i,1)];
        else
        end
    end

end


end

