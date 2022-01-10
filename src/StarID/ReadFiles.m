function [BSCatalog, Kvector, a1, a0] = ReadFiles(FoVx, FoVy, ThresholdMag)
%READFILES
%  어레이 형태로 Kvector a1,a0, 별 카탈로그 읽기
if isdeployed
    filepath = './Kvector/';
    filename1 = "Kvector_a1a0_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename2 = "Kvector_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename3 = "BSCatalog.txt";
else    
    filepath = "../BSCatalog/";
    filename1 = "Kvector_a1a0_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename2 = "Kvector_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename3 = "BSCatalog.txt";
end

fid = fopen(string(filepath)+string(filename1),'rt');
a1a0 = textscan(fid,'%f%f');
fclose(fid);

if isdeployed
    BSCatalog = readmatrix(""+filename3);
else
    BSCatalog = readmatrix(string(filepath)+filename3);
end

a1 = a1a0{1};
a0 = a1a0{2};
Kvector = readmatrix(string(filepath)+string(filename2));    
end

