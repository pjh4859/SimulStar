function [image] = MakeImage(imgMAT,inputBlur)

I = rgb2gray(imgMAT);
if inputBlur.ActiveBlur == 1
    img = imgaussfilt(I, inputBlur.sigma, 'FilterSize', 7, 'FilterDomain', 'spatial');
else
    img = I;
end
image = uint8(img);
end

