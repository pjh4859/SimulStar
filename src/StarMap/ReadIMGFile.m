function [IMG] = ReadIMGFile(filepath)
%READIMGFILE
%   이미지 파일을 읽는 함수

if isdeployed
    filepath2 = './StarIMG/';  
else    
    filepath2 = "../StarIMG/";  
end

if strlength(filepath) >= 1
    filepath = strcat(filepath, 'Test1.pgm'); 
else
    filepath = strcat(filepath2, 'Test1.pgm'); 
end

IMG = imread(filepath);            
end

