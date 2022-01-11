function [SequenceFile] = ReadPosiFile(filepath)
%READPOSIFILE 이 함수의 요약 설명 위치
%   자세한 설명 위치
if isdeployed
    filepath2 = './TrackingFile/';  
else    
    filepath2 = "../TrackingFile/";  
end

if strlength(filepath) >= 1
    filepath = strcat(filepath, 'TrackingFile3.txt'); 
else
    filepath = strcat(filepath2, 'TrackingFile3.txt'); 
end

SequenceFile = readmatrix(filepath);    

end

