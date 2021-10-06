function [StarMatrix] = Transform2Starmap(outputCatalog, inputParam)

    for i=1:size(outputCatalog,1)
        RA_Star = outputCatalog(i,2);
        DEC_Star = outputCatalog(i,3);
        
        temp = Transform.QuaternionRotate(inputParam,RA_Star,DEC_Star);
        StarVector_Tracker(i,:) = temp;        
        StarMatrix = StarVector_Tracker;
    end    

end