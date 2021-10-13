function results = ShowStatus(Params)
global randNum randObjNum;
temp2 = [];
temp = [strcat('RA:',string(Params.RA),' DEC:',string(Params.DEC), ' ROT:',string(Params.ROT), '(deg)    MagLimit:',string(Params.Mag), ...
    '    FoVxy:',string(Params.FoVx),'x',string(Params.FoVy),'(deg)    PixelNum_XY:',string(Params.PixelNum_X), 'x',string(Params.PixelNum_Y),...
    ' '), strcat('BlurInfo//','  Sigma:',string(Params.sigma),'  K1, K2, K3:', string(Params.K1),', ',string(Params.K2),', ',string(Params.K3))];
if Params.ActiveNoise
    temp2 = strcat('BackNoise: ',string(Params.MinNoise),'~',string(Params.MaxNoise),'(uint8) ');
    temp(3) = temp2;
end
if Params.ActiveMissing
    temp2 = strcat(temp2, '  Missing Stars#:',string(randNum));
    temp(3) = temp2;
end
if Params.ActiveRandObj
    temp2 = strcat(temp2, '  RandomObject#:', string(randObjNum));
   temp(3) = temp2; 
end
results = cellstr(temp);
end