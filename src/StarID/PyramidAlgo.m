function [DeterminedStarMap] = PyramidAlgo(Kvector, StarCenter, Params)
%PYRAMIDALGO
%   피라미드 알고리즘을 통해 현재 화면에 나타나 있는 별들이 어떤 별들인지 정보를 반환.

% StarCenter 의 별들 중 세개씩 골라 서로간의 각을 구함.
StarNum = size(StarCenter,1);
StarPairAngle = [];
StarCandi1 = [];
StarCandi2 = [];
StarCandi3 = [];
TriFlag = 0;
PyrFlag = 0;


count = 0;
% StarNum Combination 3 Loop.
for dj = 1:(StarNum-2)
    for dk = 1:(StarNum - dj - 1)
        for i = 1:(StarNum - dj - dk)
            j = i+dj;
            k = j + dk;
            

            combi = [i, j, k];            
            combiArr = nchoosek(combi,2);
            for q = 1:size(combiArr) % Size Must be 3.
                Star1 = [StarCenter(combiArr(q,1),1), StarCenter(combiArr(q,1),2)];
                Star2 = [StarCenter(combiArr(q,2),1), StarCenter(combiArr(q,2),2)];
                [OutAngle] = CalPix2Deg(Params.FoVx,Params.FoVy,Params.pixX,Params.pixY, Star1, Star2);
                StarPairAngle = [StarPairAngle; OutAngle];                
            end
            % 각 세개를 각각 만족하는 후보군 찾기
            [StarCandi1,StarCandi2,StarCandi3]=FindTriangle(Kvector,StarPairAngle,Params.a1,Params.a0);
%                 트라이앵글이 되는지 안되는지 찾기.
            [TriStar,TriFlag] = ConfirmTriangle(StarCandi1,StarCandi2,StarCandi3);
%                 트라이앵글이 안되면 다시 다른 세 별 찾아서
            if TriFlag
                r = SelectReferenceStar(i,j,k);         
                FindPyramid();
                if PyrFlag
                    if UniqueSol()
                        return;
                    end
                end
            end
                
            count = count+1;
            StarPairAngle = [];
        end
    end
end

%Purge specu;ar solution


% Failure: return error code

end

