function [outputCatalog] = Select_Stars(inputCatalog,inputParam)
%Select_Star: 그림으로 표현할 영역 내에 존재하는 별을 추려내는 함수.
%   자세한 설명 위치
% FoV들의 대각을 구하는 식: 피타고라스로 했기 때문에 수정이 필요함.
    Radius = sqrt(inputParam.FoVx^2 + inputParam.FoVy^2)/2;
    CenterVector = Transform.Celestial2Cartesian(inputParam.RA,inputParam.DEC);  
    
    n=uint32(1);

    for i=1:size(inputCatalog,1)
        RA_Star = inputCatalog(i,2);
        DEC_Star = inputCatalog(i,3);
        StarVector = Transform.Celestial2Cartesian(RA_Star,DEC_Star);
        if (dot(CenterVector,StarVector) >= cosd(Radius))
            outputCatalog(n,:) = inputCatalog(i,:);
            n = n+1;
        end
    end   
end

