function img =  main(Params)
arguments
    Params = struct('RA',85,'DEC',0,'ROT',0,'FoVx',30,'FoVy',30,'Mag',3.5,...
        'PixelNum_X',1024,'PixelNum_Y',1024, 'sigma',1,'K1',1500,'K2',0.6,'K3',1.2,'ActiveBlur',true);
end
global Debugmode;
Debugmode = 0;
%Erase Debug Files
EraseFiles;
%     input parameters
[inputParam, inputPixel, inputBlur] = Parameters(Params);
%     txt 파일에서 데이터 읽기
if isdeployed
    inputCatalog = ReadCatalog.array('BSCatalog.txt');
else
    inputCatalog = ReadCatalog.array();
end
%     원하는 별 고르기
outputCatalog = SelectStars(inputCatalog, inputParam);
%     고른 별 StarTracker Coordinate로 좌표 변환하기
StarPlaneMatrix = Transform2Starmap(outputCatalog, inputParam);
%     Starmap projection
StarmapPosiMAT = StarmapProjection(StarPlaneMatrix, inputPixel, inputParam, inputBlur);
%     make image
img = MakeImage(StarmapPosiMAT, inputBlur);

end