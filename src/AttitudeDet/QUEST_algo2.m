function [AttiQuaternion] = QUEST_algo2(ImageVector,CatalogVector)
%QUEST_ALGO
%   QUEST Algorithm
% clc;clear;


% CAUTION: 
% Matlab aerospace toolbox's quaternion convention is scalar-first.
% Markley's textbook quaternion convention is scalar-last.

% pick random quaternion
% q=randn(1,4); q=q/norm(q);
% dcm = quat2dcm(q);
% 
% % generate n random unit vectors
% 
[rows,~] = size(ImageVector);
NormImageVector = [];

a = ones(1,rows)/rows; % weight 

r = CatalogVector';
for i=1:rows
    NormImageVector = [NormImageVector ; ImageVector(i,:)/norm(ImageVector(i,:))];
end
b = NormImageVector';

% b=dcm*r; % measured vector

% davenport's q method

B = zeros(3,3); % attitude profile matrix
for i=1:rows
    B = B + a(i)*b(:,i)*r(:,i)';
end

z = [B(2,3)-B(3,2);
     B(3,1)-B(1,3);
     B(1,2)-B(2,1)];

% scalar-first quaternion convention (MATLAB aerospace toolbox)
K = [ trace(B) z' 
      z B+B'-trace(B)*eye(3)];

% scalar-last quaternion (Markley-Crassidis textbook)
% K = [ B+B'-trace(B)*eye(3) z;
%       z' trace(B)      ];

[Q, L] = eig(K);
lambda = diag(L);
[max_labmda_devenport, max_idx_devenport] = max(lambda);

disp('input quaternion');
% q
disp('estimated quaternion - devenport q method');
q_devenport = Q(:,max_idx_devenport)'

% quest algorithm

S = B + B';
lambda0 = sum(a);
fsolve_fun = @(x) quest_equation(x, B,z,S);
options=optimoptions('fsolve','display','off');
max_lambda_quest = fsolve(fsolve_fun,lambda0,options);
rho = max_lambda_quest + trace(B);

disp('solution of quest equation');
max_lambda_quest

disp('estimated quaternion - quest algoirhtm');

% Markley text book convention - scalar last quaternion
% q_quest = [adjoint(rho*eye(3)-S)*z; det(rho*eye(3)-S)];

% MATLAB quaternion convention - scalar first quaternion
q_quest = [det(rho*eye(3)-S); adjoint(rho*eye(3)-S)*z]';
q_quest = q_quest / norm(q_quest)

AttiQuaternion = q_quest;
end

