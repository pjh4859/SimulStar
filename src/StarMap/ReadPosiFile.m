function [SequenceFile] = ReadPosiFile(filepath)
%READPOSIFILE 이 함수의 요약 설명 위치
%   자세한 설명 위치
arguments
    filepath = '../TrackingFile/';
end

filepath = strcat(filepath, 'TrackingFile.txt');

SequenceFile = readmatrix(filepath);    

end

