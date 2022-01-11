function WriteOutput(app)
%WRITEOUTPUT 이 함수의 요약 설명 위치
%   자세한 설명 위치
filepath = '../OutputFile/';

if ~exist(filepath)
    mkdir(filepath);
end
filepath1 = strcat(filepath, 'SuccessID.txt');

writematrix(app.SuccessID,filepath1,'Delimiter','tab');

end

