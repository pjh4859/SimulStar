function [outputArg1,outputArg2] = main_AttiDet(inputArg1,inputArg2)
%MAIN_ATTIDET

[Kvector,outputArg1] = Make_Svector(FoVx, FoVy, ThresholdMag);
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

