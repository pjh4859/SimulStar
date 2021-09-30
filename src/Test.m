% Coordinate transform from (RA, DEC) -> (theta, phi)

function [theta, phi] RADEC2THETAPI(RA,DEC)
    theta = RA;
    phi  = 90.0-DEC;
end

% Inner product of R which points center of the screen and S which points star 
% from the origin
function RdotS(phi_Center, theta_Center, phi_Star, theta_Star)
    sin(phi_Star)*cos(theta_Star)*sin(phi_Center)*cos(theta_Center) ...
  + sin(phi_Star)*sin(theta_Star)*sin(phi_Center)*sin(theta_Center) ...
  + cos(phi_Star)*cos(phi_Center);

% Center position (RA, DEC) and FOV angle
RA_Center = inputParam.RA;
DEC_Center = inputParam.DEC;
ANGLE = inputParam.ANGLE;

% Coordinate transform from (RA, DEC) -> (theta, phi)
[theta_Center, phi_Center] = RADEC2THETAPI(RA_Center, DEC_Center);


n = uint32(1);

for i=1:size(inputCatalog,1)
    RA_Star=inputCatolog(i,2);
    DEC_Star=inputCatolog(i,3);
    [theta_Star, phi_Star] = RADEC2THETAPI(RA_Star,DEC_Star)
    if ( RdotS(phi_Center, theta_Center, phi_Star, theta_Star) <cos(ANGLE) )
        outputCatalog(n,:) = inputCatalog(i,:);
        n = n+1;
    end
end
