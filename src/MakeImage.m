function [image] = MakeImage(imgMAT,inputImage)
% Input is uint16 image data. We will make it uint8 image data with hard
% casting.
img = rgb2gray(imgMAT);
if inputImage.ActiveBlur == 1
    img = imgaussfilt(img, inputImage.sigma, 'FilterSize', 7, 'FilterDomain', 'spatial');
end

if inputImage.ActiveNoise == 1
%     img = imnoise(img, 'gaussian',0.00000000001, 0.00001);
    img = MakeNoise(img, inputImage);
end
image = uint8(img);
end

function [NoiseMAT] =  MakeNoise(imgMAT,inputImage)
    YXsize = size(imgMAT);
    for i=1:YXsize(2)
        for j=1:YXsize(1)
            imgMAT(j,i) = imgMAT(j,i) + randi([inputImage.MinNoise, inputImage.MaxNoise]);            
        end       
    end
    NoiseMAT = imgMAT;
end