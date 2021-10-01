classdef Transform 
%좌표계 변환 클래스
    methods     ( Static = true )        
        function [theta, phi] = RADEC2THETAPI(RA,DEC)
%             theta = RA*pi/180.0;
%             phi  = (90.0-DEC)*pi/180.0;
            theta = RA;
            phi  = 90.0-DEC;
        end
        
        function [Vector] = Celestial2Cartesian(RA, DEC)
            U = cosd(RA)*cosd(DEC);
            V = sind(RA)*cosd(DEC);
            W = sind(DEC);
            Vector = [U,V,W];
        end
        
        % Inner product of R which points center of the screen and S which points star 
        % from the origin
        function Output = RdotS(phi_Center, theta_Center, phi_Star, theta_Star)
            Output =  sind(phi_Star)*cosd(theta_Star)*sind(phi_Center)*cosd(theta_Center) ...
            + sind(phi_Star)*sind(theta_Star)*sind(phi_Center)*sind(theta_Center) ...
            + cosd(phi_Star)*cosd(phi_Center);
            % Center position (RA, DEC) and FoV angle
%             RA_Center = inputParam.RA;
%             DEC_Center = inputParam.DEC;
%             FoV = inputParam.FoV*pi/180.0;
%             Angle = acos( 1.0-FoV/(2.0*pi) ); 
        end
        
    end
end


