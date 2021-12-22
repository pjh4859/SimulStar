function [file] = MakeTrackingFile(filepath)
%MAKETRACKINGFILE
%   트래킹 모드에 들어갈 텍스트 파일을 생성하는 함수
arguments
    filepath = '../TrackingFile/';
end

if ~exist(filepath)
    mkdir(filepath);
end

filepath = strcat(filepath, 'TrackingFile.txt');

M = [0:180; 0:180; -90:90; 0:180];
M = M';
writematrix(M,filepath,'Delimiter','tab');

% fileID = fopen(filepath,'w');
% fprintf(fileID, 

end