classdef Transform
    % 좌표계 변환 클래스
    % # 구성 목록
    % 1. RADEC2THETAPI: 
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

        function [M] = QuaternionRotate(inputParam, Star_RA, Star_DEC)
            global Debugmode

            phi = inputParam.RA - 90;
            theta = inputParam.DEC - 90;
            psi = inputParam.ROT;
            [x,y,z] = sph2cart(Star_RA*pi/180, Star_DEC*pi/180, 1);
            vector = [x,y,z];

            q1 = [cosd(phi/2), 0, 0, sind(phi/2)];
            q2 = [cosd(theta/2), sind(theta/2), 0, 0];
            q3 = [cosd(psi/2), 0, 0, sind(psi/2)];

            temp = quatmultiply(q1,q2);
            q = quatmultiply(temp,q3);

            M = quatrotate(q,vector);
            %             For Debuging
            %             if feature('IsDebugMode')
            if Debugmode
                fileID = fopen('../StarVector_Transformed.txt','a');
                fprintf(fileID,"%f %f %f\n",M(1),M(2),M(3));
                fclose(fileID);
            end
            %             end
        end
    end
end


