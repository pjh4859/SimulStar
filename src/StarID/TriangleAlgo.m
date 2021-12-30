function     [DeterminedStarMap,TriFlag] = TriangleAlgo(BSCatalog, Kvector, StarCenter, Params)
%TRIANGLEALGO
%   트라이앵글 알고리즘을 통해 현재 화면에 나타나 있는 별들이 어떤 별들인지 정보를 반환.

% StarCenter 의 별들 중 세개씩 골라 서로간의 각을 구함.
StarNum = size(StarCenter,1);
StarPairAngle = [];
StarCandi1 = [];
StarCandi2 = [];
StarCandi3 = [];
TriFlag = 0;

DeterminedStarMap = [];

count = 0;
% StarNum Combination 3 Loop.
for dj = 1:(StarNum-2)
    for dk = 1:(StarNum - dj - 1)
        for i = 1:(StarNum - dj - dk)
            j = i+dj;
            k = j + dk;
            
            % combi의 ijk 는 이미지에 라벨링된 별 번호.
            combi = [i, j, k];            
            combiArr = nchoosek(combi,2);
            for q = 1:size(combiArr) % Size Must be 3.
                % Star1 or Star2 배열의 모양. [이미지 X좌표, 이미지 Y좌표, 별 라벨번호]
                Star1 = [StarCenter(combiArr(q,1),1), StarCenter(combiArr(q,1),2), combiArr(q,1)];
                Star2 = [StarCenter(combiArr(q,2),1), StarCenter(combiArr(q,2),2), combiArr(q,2)];
                % 픽셀위치에서 각거리를 구한다.
                % OutAngle 배열의 모양. [Star1과 Star2의 각거리, Star1의 라벨 번호, Star2의 라벨 번호]
                [OutAngle] = CalPix2Deg(Params.FoVx,Params.FoVy,Params.pixX,Params.pixY, Star1, Star2);
                % 각들을 배열로 추가함.
                StarPairAngle = [StarPairAngle; OutAngle];                
            end
            % Degree 세 개를 각각 만족하는 후보군 찾기
            [StarCandi1,StarCandi2,StarCandi3]=FindTriangleCandi(Kvector,StarPairAngle,Params.a1,Params.a0);
            % 트라이앵글이 되는지 안되는지 찾기.
            % 여기서 구해진 TriStar 후보군의 이미지에서의 라벨 번호는 i j k.
            [TriStar,TriFlag] = ConfirmTriangle(StarCandi1,StarCandi2,StarCandi3);
            % 트라이앵글이 안되면 다시 다른 세 별 찾아서
            if TriFlag
                % MatchTri 배열의 형태 [별 라벨i,j,k, K벡터상 별 인덱스 A,B,C]
                [DeterminedStarMap] = MatchTriangle(TriStar, BSCatalog, StarPairAngle);  
            end                
            count = count+1;
            StarPairAngle = [];
        end
    end
end


%Purge specu;ar solution


% Failure: return error code
end

