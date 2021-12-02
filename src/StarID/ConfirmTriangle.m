function [TriStarArr,TriFlag] = ConfirmTriangle(StarCandi1,StarCandi2,StarCandi3)
%CONFIRMTRIANGLE
% 세 각을 통해 얻어낸 Star Pair 후보군 3개를 통해 삼각형을 이루는 후보군을 찾아 반환하는 함수.
% TriStarArr 는 빈 배열부터 여러 후보가 있는 배열.
% TriFlag 는 0 또는 1로 0일 경우 삼각형을 하나도 못 찾은 경우, 1은 하나 이상 찾은 경우.
TriStarArr = [];
TriFlag = 0;

for i=1:size(StarCandi1,1)
    arr1x = StarCandi1(i,2);
    arr1y = StarCandi1(i,3);
    
    for j = 1:size(StarCandi2,1)
        arr2x = StarCandi2(j,2);
        arr2y = StarCandi2(j,3);
        
        for k = 1:size(StarCandi3,1)
            arr3x = StarCandi3(k,2);
            arr3y = StarCandi3(k,3);
            
            if arr1x == arr2x
                n=1;
            elseif arr1x == arr2y
                n=2;
            elseif arr1y == arr2x
                n=3;
            elseif arr1y == arr2y
                n=4;
            else
                n=0;
            end
            
            switch n
                case 1
                    if arr1y == arr3x && arr2y == arr3y
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3y]]; 
                    elseif arr1y == arr3y && arr2y == arr3x
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3x]]; 
                    end 
                case 2
                    if arr1x == arr3x && arr2y == arr3y
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3y]]; 
                    elseif arr1x == arr3y && arr2y == arr3x
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3x]]; 
                    end 
                case 3
                    if arr1y == arr3x && arr2x == arr3y
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3y]]; 
                    elseif arr1y == arr3y && arr2x == arr3x
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3x]]; 
                    end 
                case 4
                    if arr1x == arr3x && arr2x == arr3y
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3y]]; 
                    elseif arr1x == arr3y && arr2x == arr3x
                        TriFlag = 1;
                        TriStarArr = [TriStarArr; [arr1x,arr1y,arr3x]]; 
                    end 
                otherwise
            end
        end
    end    
end

end

