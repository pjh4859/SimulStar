function [StarPlaneMatrix] = Transform2Starmap(outputCatalog, inputParam)

    for i=1:size(outputCatalog,1)
        RA_Star = outputCatalog(i,2);
        DEC_Star = outputCatalog(i,3);
        
        temp = Transform.QuaternionRotate(inputParam,RA_Star,DEC_Star);
        StarVector_Tracker(i,:) = temp;        
    end    
    StarMatrix = StarVector_Tracker;
    StarPlane = Starmap2Starplane(StarMatrix, inputParam);
    StarPlaneMatrix = StarPlane;
%     StarPlaneMatrix = StarMatrix;
end

% Star Tracker coordinate 로 변환한 별 벡터들을 z가 일정한 평면으로 프로젝션.
function [StarPlane] = Starmap2Starplane(StarMatrix, inputParam)
     for i=1:size(StarMatrix,1)
        Axis_z = [0,0,1];
        Star_x = StarMatrix(i,1);
        Star_y = StarMatrix(i,2);
        Star_z = StarMatrix(i,3);
        StarVector = [Star_x, Star_y, Star_z];
        Radius = sqrt(inputParam.FoVx^2 + inputParam.FoVy^2)/2;
        term1 = tand(acosd(dot(Axis_z,StarVector)));
        
        Plane_x = cosd(Radius)*term1*Star_x/(sqrt(Star_x^2+Star_y^2));
        Plane_y = cosd(Radius)*term1*Star_y/(sqrt(Star_x^2+Star_y^2));
        Plane_z = cosd(Radius);
        
        Plane(i,:) = [Plane_x,Plane_y,Plane_z];        
        fileID = fopen('../StarVector_Plane.txt','a');
        fprintf(fileID,"%f %f %f\n",Plane_x,Plane_y,Plane_z);
        fclose(fileID);
     end         
    StarPlane = Plane;
end
        