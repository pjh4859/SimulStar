function [inputParam,inputPixel] = Parameters(Params)
    inputParam = struct('RA',Params.RA,'DEC',Params.DEC,'ROT',Params.ROT,'FoVx',Params.FoVx,'FoVy',Params.FoVy,'MagLimit',Params.Mag);
    inputPixel = struct('PixelNum_X',Params.PixelNum_X,'PixelNum_Y',Params.PixelNum_Y);
end