function GreyValue = StarGrey_mag(inputBlur, StarMag)
GreyValue = inputBlur.K1*exp(-inputBlur.K2*StarMag + inputBlur.K3);
% constrain value.
if GreyValue > 65535
    GreyValue = 65535;
end
end