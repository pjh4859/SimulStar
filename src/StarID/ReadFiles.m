function [BSCatalog, Kvector, a1, a0] = ReadFiles(FoVx, FoVy, ThresholdMag)
%READFILES
%  어레이 형태로 Kvector a1,a0, 별 카탈로그 읽기
filepath = "../BSCatalog/";
filename1 = "Kvector_a1a0_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
filename2 = "Kvector_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
filename3 = "BSCatalog.txt";


fid = fopen(string(filepath)+string(filename1),'rt');
a1a0 = textscan(fid,'%f%f');
fclose(fid);
 
BSCatalog = readmatrix(string(filepath)+filename3);
% a1a0 = readmatrix(string(filepath)+string(filename1));
a1 = a1a0{1};
a0 = a1a0{2};
Kvector = readmatrix(string(filepath)+string(filename2));    

end

