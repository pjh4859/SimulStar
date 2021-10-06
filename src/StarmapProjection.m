function [StarmapPosiMAT] = StarmapProjection(StarMatrix)
    for i=1:size(StarMatrix,1)
        x = StarMatrix(i,1);
        y = StarMatrix(i,2);
        
        StarmapPosition(i,:) = [x,y];        
        StarmapPosiMAT(1024,1024) = 0;
        StarmapPosiMAT(round(1024/2*x)+512,round(1024/2*(-y))+512) = 255;
    end

end