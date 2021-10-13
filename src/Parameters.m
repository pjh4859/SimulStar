function [inputParam,inputPixel,inputImage] = Parameters(Params)
inputParam = struct('RA',Params.RA,'DEC',Params.DEC,'ROT',Params.ROT,'FoVx',Params.FoVx,'FoVy',Params.FoVy,'MagLimit',Params.Mag);
inputPixel = struct('PixelNum_X',Params.PixelNum_X,'PixelNum_Y',Params.PixelNum_Y);
inputImage = struct('sigma',Params.sigma,'K1',Params.K1,'K2',Params.K2,'K3',Params.K3,'ActiveBlur',Params.ActiveBlur,...
    'MaxNoise',Params.MaxNoise,'MinNoise',Params.MinNoise,'ActiveNoise',Params.ActiveNoise,...
    'MissingMax',Params.MissingMax,'MissingMin',Params.MissingMin,'ActiveMissing',Params.ActiveMissing,'MissingNum',NaN);
end

%             Params.RandObjMaxNum = app.ObjNumMaxEditField.Value;
%             Params.RandObjMinNum = app.ObjNumMinEditField.Value;
%             Params.RandObjMaxRadi = app.ObjRadiusMaxEditField.Value;
%             Params.RandObjMinRadi = app.ObjRadiusMinEditField.Value;
%             Params.ActiveRandObj = app.EnableButton_RandObj.Value;);