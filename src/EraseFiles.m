function EraseFiles()
%     Erase Debuging .txt
if(exist('../outputCatalog.txt', 'file'))
    delete '../outputCatalog.txt';
end
if(exist('../StarVector_Transformed.txt', 'file'))
    delete '../StarVector_Transformed.txt';
end
if(exist('../StarVector.txt', 'file'))
    delete '../StarVector.txt';
end
if(exist('../StarVector_Plane.txt', 'file'))
    delete '../StarVector_Plane.txt';
end
end

