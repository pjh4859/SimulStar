function [inputParam,inputPixel,inputBlur] = Parameters(Params)
    inputParam = struct('RA',Params.RA,'DEC',Params.DEC,'ROT',Params.ROT,'FoVx',Params.FoVx,'FoVy',Params.FoVy,'MagLimit',Params.Mag);
    inputPixel = struct('PixelNum_X',Params.PixelNum_X,'PixelNum_Y',Params.PixelNum_Y);
    inputBlur = struct('sigma',Params.sigma,'K1',Params.K1,'K2',Params.K2,'K3',Params.K3,'ActiveBlur',Params.ActiveBlur);
end