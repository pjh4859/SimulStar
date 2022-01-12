function WriteOutput(app)
%WRITEOUTPUT 이 함수의 요약 설명 위치
%   자세한 설명 위치
filepath = '../OutputFile/';

if ~exist(filepath)
    mkdir(filepath);
end
filepath1 = strcat(filepath, 'SuccessID.txt');
filepath2 = strcat(filepath, 'Quaternion.txt');
filepath3 = strcat(filepath, 'Attitude.txt');

writematrix(app.SuccessID,filepath1,'Delimiter','tab');
writematrix(app.Quaternion,filepath2,'Delimiter','tab');
writematrix(app.Attitude,filepath3,'Delimiter','tab');


end

