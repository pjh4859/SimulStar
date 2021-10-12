function [StarmapPosiMAT] = StarmapProjection(StarMatrix, inputPixel, inputParam, inputBlur)
StarmapPosiMAT(inputPixel.PixelNum_Y,inputPixel.PixelNum_X,3) = 0;
for i=1:size(StarMatrix,1)
    x = StarMatrix(i,1);
    y = StarMatrix(i,2);
    Star_Mag = StarMatrix(i,4);
    %
    %         StarmapPosition(i,:) = [x,y];
    %         StarmapPosiMAT(1024,1024) = 0;
    %         StarmapPosiMAT(round(1024/2*x)+512,round(1024/2*(-y))+512) = 255;
    Radius = sqrt(inputParam.FoVx^2 + inputParam.FoVy^2)/2;
    Plane_x = round((inputPixel.PixelNum_X/2)/(cosd(Radius)*tand(inputParam.FoVx/2))*(x) + (inputPixel.PixelNum_X/2)) +1;
    Plane_y = round((inputPixel.PixelNum_Y/2)/(cosd(Radius)*tand(inputParam.FoVy/2))*(y) + (inputPixel.PixelNum_Y/2)) +1;
    StarmapPosition(i,:) = [Plane_x, Plane_y, Star_Mag];
    
    %         fprintf("%f %f\n",Plane_x, Plane_y);
    
    if (Plane_x <=inputPixel.PixelNum_X && Plane_x > 0 && Plane_y <= inputPixel.PixelNum_Y && Plane_y >0)
        if inputBlur.ActiveBlur == 1
            GreyValue = StarGrey_mag(inputBlur,Star_Mag);
            StarmapPosiMAT(Plane_y,Plane_x,1) = Utile.ConstrainUint16(StarmapPosiMAT(Plane_y,Plane_x,1), GreyValue);
            StarmapPosiMAT(Plane_y,Plane_x,2) = Utile.ConstrainUint16(StarmapPosiMAT(Plane_y,Plane_x,2), GreyValue);
            StarmapPosiMAT(Plane_y,Plane_x,3) = Utile.ConstrainUint16(StarmapPosiMAT(Plane_y,Plane_x,3), GreyValue);
        else
            StarmapPosiMAT(Plane_y,Plane_x) = 65535;
            StarmapPosiMAT(Plane_y,Plane_x,2) = 65535;
            StarmapPosiMAT(Plane_y,Plane_x,3) = 65535;
        end
        StarmapPosiMAT = cast(StarmapPosiMAT, 'uint16');
    end
end

end