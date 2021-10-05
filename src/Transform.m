classdef Transform 
%좌표계 변환 클래스
    methods     ( Static = true )        
        function [theta, phi] = RADEC2THETAPI(RA,DEC)
%             theta = RA*pi/180.0;
%             phi  = (90.0-DEC)*pi/180.0;
            theta = RA;
            phi  = 90.0 - DEC;
        end
        
        function [Vector] = Celestial2Cartesian(RA, DEC)
            U = cosd(RA)*cosd(DEC);
            V = sind(RA)*cosd(DEC);
            W = sind(DEC);
            Vector = [U,V,W];
        end

        function [Vector] = Celestial2Cartesian2(RA, DEC)
            RA = RA * pi/180;
            DEC = DEC * pi/180;
            U = cos(RA)*cos(DEC);
            V = sin(RA)*cos(DEC);
            W = sin(DEC);
            Vector = [U,V,W];
        end
        
        function [M] = Cel2Sensor_Matrix(RA, DEC, ROT)
            a1 =
            M = [];                      
        end
        
        
    end
end


