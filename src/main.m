function main()
%     Erase Debuging .txt
    if(exist('../StarVector_Transformed.txt', 'file'))
        delete '../StarVector_Transformed.txt';
    end
    if(exist('../StarVector.txt', 'file'))
        delete '../StarVector.txt';
    end
    if(exist('../StarVector_Plane.txt', 'file'))
        delete '../StarVector_Plane.txt';
    end   

%     input parameters
    inputParam = struct('RA',85,'DEC',0,'ROT',0,'FoVx',30,'FoVy',30,'MagLimit',2.8);
    inputPixel = struct('PixelNum_X',1024,'PixelNum_Y',1024);
%     txt 파일에서 데이터 읽기
    inputCatalog = ReadCatalog.array();
%     원하는 별 고르기
    outputCatalog = SelectStars(inputCatalog, inputParam);
%     고른 별 StarTracker Coordinate로 좌표 변환하기
    StarPlaneMatrix = Transform2Starmap(outputCatalog, inputParam);
%     Starmap projection
    StarmapPosiMAT = StarmapProjection(StarPlaneMatrix,inputPixel,inputParam);
%     show image
    imshow(StarmapPosiMAT);
end