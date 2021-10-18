function [image] = MakeImage(imgMAT,inputImage,inputPixel)
% Input is uint16 image data. We will make it uint8 image data with hard
% casting.
img = rgb2gray(imgMAT);
if inputImage.ActiveBlur == 1
    img = imgaussfilt(img, inputImage.sigma, 'FilterSize', 7, 'FilterDomain', 'spatial');
end

if inputImage.ActiveNoise == 1
    %     img = imnoise(img, 'gaussian',0.001, 0.001);
    img = MakeNoise(img, inputImage);
end

if inputImage.ActiveRandObj == 1
    img = MakeObject(img, inputImage,inputPixel);
end


image = uint8(img);
end



% Making Noise Part
function [NoiseMAT] =  MakeNoise(imgMAT,inputImage)
YXsize = size(imgMAT);
for i=1:YXsize(2)
    for j=1:YXsize(1)
        imgMAT(j,i) = imgMAT(j,i) + randi([inputImage.MinNoise, inputImage.MaxNoise]);
    end
end
NoiseMAT = imgMAT;
end

% Making Random Object
function [ObjectMAT] = MakeObject(imgMAT,inputImage,inputPixel)
global randObjNum;
randObjNum = randi([inputImage.RandObjMinNum,inputImage.RandObjMaxNum]);
randx = randi([1,inputPixel.PixelNum_X],1,randObjNum);
randy = randi([1,inputPixel.PixelNum_Y],1,randObjNum);

for i=1:randObjNum
    imgMAT(randy(i), randx(i)) = 65535;
    ranRadi = randi([inputImage.RandObjMinRadi,inputImage.RandObjMaxRadi]);
    for j=randy(i)-ranRadi:randy(i)+ranRadi
        for k=randx(i)-ranRadi:randx(i)+ranRadi
            areaPosi = (k-randx(i))^2 + (j-randy(i))^2;
            if areaPosi > ranRadi^2
                continue
            end
            if (k<1) || (j<1) || (k>inputPixel.PixelNum_X) || (j>inputPixel.PixelNum_Y)
                continue
            end            
            imgMAT(j,k) = 65535;
        end
    end
end
ObjectMAT = imgMAT;
end