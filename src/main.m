function main()
%     Erase Debuging .txt
    delete '../StarVector_Transformed.txt';
    delete '../StarVector.txt';
%     input parameters
    inputParam = struct('RA',85,'DEC',0,'ROT',0,'FoVx',20,'FoVy',20);
%     txt 파일에서 데이터 읽기
    inputCatalog = ReadCatalog.array();
%     원하는 별 고르기
    outputCatalog = SelectStars(inputCatalog, inputParam);
%     고른 별 StarTracker Coordinate로 좌표 변환하기
    StarMatrix = Transform2Starmap(outputCatalog, inputParam);
%     Starmap projection
    StarmapPosiMAT = StarmapProjection(StarMatrix);
%     show image
    imshow(StarmapPosiMAT);
end