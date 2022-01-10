function [IMG] = ImgProcessing(IMG,Camera)
%IMGPROCESSING
%   카메라에 따라 이미지 프로세싱 하기
switch(Camera)
    case 1
        IMG = immultiply(IMG,5);
        IMG = wiener2(IMG,[5 5]);
%         IMG = IMG-10000;
        column_offsets = median(IMG);
        column_offsets = column_offsets - min(column_offsets);
        new_im = bsxfun(@minus,IMG,column_offsets);
        J = imadjust(new_im,[],[],2.5);
        IMG = J;
        IMG = IMG - 4000;
        IMG(965:966,:) = 0;
         % 16bit to 8bit
        IMG = uint8(IMG/256);
end

