function [IMG] = ReadIMGFile(filepath)
%READIMGFILE
%   이미지 파일을 읽는 함수
arguments
    filepath = '../StarIMG/';
end

filepath = strcat(filepath, 'Test3.pgm');

IMG = imread(filepath);            
end

