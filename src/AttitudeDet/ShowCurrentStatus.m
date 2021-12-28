function [results] = ShowCurrentStatus(Attitude)
%SHOWCURRENTSTATUS
%   현재 상태를 표시

temp = [strcat('RA:',string(Attitude.RA),' DEC:',string(Attitude.DEC), ' ROT:',string(Attitude.ROT), '(deg)')];

results = temp;
end

