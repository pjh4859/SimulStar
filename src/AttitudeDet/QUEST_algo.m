function [AttiQuaternion] = QUEST_algo(ImageVector,CatalogVector)
%QUEST_ALGO
%   QUEST Algorithm
NormImageVector = [];
[rows,~] = size(ImageVector);

if rows == 4
    a = [1/4, 1/4, 1/4, 1/4];
elseif rows ==3
    a = [1/3, 1/3, 1/3];
end

for i=1:rows
    NormImageVector = [NormImageVector ; ImageVector(i,:)/norm(ImageVector(i,:))];
end

B = zeros(3,3);
Z = zeros(1,3);
omega = 0;
for i=1:rows
    %Attitude profile matrix
    % weightage for all measurements to be given 1, wrongly identified stars
    B = B + a(i)*(NormImageVector(i,:))'*CatalogVector(i,:);
   
    omega = omega + a(i);
    
    Z = Z + a(i)*cross(NormImageVector(i,:),CatalogVector(i,:));
end

% Z = B - B';
S = B + B';
sigma = trace(S)/2;
kappa = trace(adjoint(S));
delta = det(S);

alpha = omega^2 - sigma^2 + kappa;
beta = omega - sigma;
gamma = (omega + sigma)*alpha - delta;

X = ((alpha*eye(3) + beta*S + S^2)*Z')';

temp_q_opt = 1/sqrt(gamma^2 + (X*X'));
% q_opt = temp_q_opt*[X , gamma];
q_opt = temp_q_opt*[gamma, X];

AttiQuaternion = q_opt;
end

