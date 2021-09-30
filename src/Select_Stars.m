function [outputCatalog] = Select_Stars(inputCatalog,inputParam)
%Select_Star: 그림으로 표현할 영역 내에 존재하는 별을 추려내는 함수.
%   자세한 설명 위치
    Radius = sqrt(inputParam.FoVx^2 + inputParam.FoVy^2)/2;
%     RAmin = inputParam.RA - inputParam.FoVx/2;
%     RAmax = inputParam.RA + inputParam.FoVx/2;
%     DECmin = inputParam.DEC - inputParam.FoVy/2;
%     DECmax = inputParam.DEC + inputParam.FoVy/2;
    
    RAmin = inputParam.RA - Radius;
    RAmax = inputParam.RA + Radius;
    DECmin = inputParam.DEC - Radius;
    DECmax = inputParam.DEC + Radius;
    
    if (RAmin < 0)
        RAmin = RAmin + 360;
    end
    if (RAmax > 360)
        RAmax = RAmax -360;
    end
    if (DECmin < -90 )
        DECmin = DECmin + 180;
    end
    if (DECmax > 90 )
        DECmax = DECmax - 180;
    end
    
    
    for i=1:size(inputCatalog,1)
%         if(inputCatalog(i,2) >= RAmin && inputCatalog(i,2) <= RAmax && inputCatalog(i,3) >= DECmin && inputCatalog(i,3) <= DECmax)
        if()  
            outputCatalog = inputCatalog(i,:);
        end
    end
    
end

