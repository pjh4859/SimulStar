function q = eul2quatZXZ( eul, varargin )
%EUL2QUAT Convert Euler angles to quaternion
%   Q = EUL2QUAT(EUL) converts a given set of 3D Euler angles, EUL, into
%   the corresponding unit quaternion, Q. EUL is an N-by-3 matrix of Euler 
%   rotation angles.
%   The output, Q, is an N-by-4 matrix containing N quaternions. Each
%   quaternion is of the form q = [w x y z], with w as the scalar number.
%
%   Q = EUL2QUAT(EUL, SEQ) converts a set of 3D Euler angles into a unit
%   quaternion. The Euler angles are specified by the body-fixed
%   (intrinsic) axis rotation sequence, SEQ.
%
%   The default rotation sequence is 'ZYX', where the order of rotation
%   angles is Z Axis Rotation, Y Axis Rotation, and X Axis Rotation.
%
%   The following rotation sequences, SEQ, are supported: 'ZYX', 'ZYZ', and
%   'XYZ'.
%
%   Example:
%      % Calculate the quaternion for a set of Euler angles
%      % By default, the ZYX axis order will be used.
%      angles = [0 pi/2 0];
%      q = eul2quat(angles)
%
%      % Calculate the quaternion based on a ZYZ rotation
%      qzyz = eul2quat(angles, 'ZYZ')
%
%   See also quat2eul

%   Copyright 2014-2019 The MathWorks, Inc.

%#codegen

robotics.internal.validation.validateNumericMatrix(eul, 'eul2quat', 'eul', ...
    'ncols', 3);

seq = 'ZXZ';

% Pre-allocate output
q = zeros(size(eul,1), 4, 'like', eul);

% Compute sines and cosines of half angles
c = cos(eul/2);
s = sin(eul/2);

% The parsed sequence will be in all upper-case letters and validated
switch seq
    case 'ZYX'
        % Construct quaternion
        q = [c(:,1).*c(:,2).*c(:,3)+s(:,1).*s(:,2).*s(:,3), ...
            c(:,1).*c(:,2).*s(:,3)-s(:,1).*s(:,2).*c(:,3), ...
            c(:,1).*s(:,2).*c(:,3)+s(:,1).*c(:,2).*s(:,3), ...
            s(:,1).*c(:,2).*c(:,3)-c(:,1).*s(:,2).*s(:,3)];
        
    case 'ZYZ'
        % Construct quaternion
        q = [c(:,1).*c(:,2).*c(:,3)-s(:,1).*c(:,2).*s(:,3), ...
            c(:,1).*s(:,2).*s(:,3)-s(:,1).*s(:,2).*c(:,3), ...
            c(:,1).*s(:,2).*c(:,3)+s(:,1).*s(:,2).*s(:,3), ...
            s(:,1).*c(:,2).*c(:,3)+c(:,1).*c(:,2).*s(:,3)];
        
    case 'XYZ'
        % Construct quaternion
        q = [c(:,1).*c(:,2).*c(:,3) - s(:,1).*s(:,2).*s(:,3), ...
            s(:,1).*c(:,2).*c(:,3) + c(:,1).*s(:,2).*s(:,3), ...
            -s(:,1).*c(:,2).*s(:,3) + c(:,1).*s(:,2).*c(:,3), ...
            c(:,1).*c(:,2).*s(:,3) + s(:,1).*s(:,2).*c(:,3)];
        
    case 'ZXZ'
        % Construct quaternion
        q = -[c(:,1).*c(:,2).*c(:,3)-s(:,1).*c(:,2).*s(:,3), ...            
             c(:,1).*s(:,2).*c(:,3)+s(:,1).*s(:,2).*s(:,3), ...
             -c(:,1).*s(:,2).*s(:,3)+s(:,1).*s(:,2).*c(:,3), ...
             s(:,1).*c(:,2).*c(:,3)+c(:,1).*c(:,2).*s(:,3)];
end

end

