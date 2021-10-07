function [StarmapPosiMAT] = StarmapProjection(StarMatrix, inputPixel, inputParam)
    StarmapPosiMAT(inputPixel.PixelNum_Y,inputPixel.PixelNum_X) = 0;
    for i=1:size(StarMatrix,1)
        x = StarMatrix(i,1);
        y = StarMatrix(i,2);
%         
%         StarmapPosition(i,:) = [x,y];        
%         StarmapPosiMAT(1024,1024) = 0;
%         StarmapPosiMAT(round(1024/2*x)+512,round(1024/2*(-y))+512) = 255;
        Radius = sqrt(inputParam.FoVx^2 + inputParam.FoVy^2)/2;
        Plane_x = fix((inputPixel.PixelNum_X/2)/(cosd(Radius)*tand(inputParam.FoVx/2))*(x) + (inputPixel.PixelNum_X/2)) +1;
        Plane_y = fix((inputPixel.PixelNum_Y/2)/(cosd(Radius)*tand(inputParam.FoVy/2))*(y) + (inputPixel.PixelNum_Y/2)) +1;
        StarmapPosition(i,:) = [Plane_x, Plane_y];     
        
%         fprintf("%f %f\n",Plane_x, Plane_y);

        if (Plane_x <=inputPixel.PixelNum_X && Plane_x > 0 && Plane_y <= inputPixel.PixelNum_Y && Plane_y >0)
            StarmapPosiMAT(Plane_y,Plane_x) = 255;
            StarmapPosiMAT(Plane_y+1,Plane_x+1) = 255;
            StarmapPosiMAT(Plane_y,Plane_x+1) = 255;       
            StarmapPosiMAT(Plane_y+1,Plane_x) = 255;
        end
    end

end