clc;clear;
%QUEST_ALGO
%   QUEST Algorithm
tic
q=randn(1,4); q=q/norm(q);
dcm = quat2dcm(q);

% generate n random unit vectors

n=4;
r=zeros(3,n); % reference vector
for i=1:n
    v=randn(3,1);
    v=v/norm(v);
    r(:,i)=v;
end
b=dcm*r; % measured vector
CatalogVector = r';
ImageVector = b';

NormImageVector = [];
[rows,~] = size(ImageVector);

a = ones(1,rows)/rows; % weight 


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
q
AttiQuaternion = q_opt
toc
%%
tic
B = zeros(3,3); % attitude profile matrix
for i=1:n
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

% disp('estimated quaternion - devenport q method');
q_devenport = Q(:,max_idx_devenport)'

% quest algorithm

S = B + B';
lambda0 = sum(a);
fsolve_fun = @(x) quest_equation(x, B,z,S);
options=optimoptions('fsolve','display','off');
max_lambda_quest = fsolve(fsolve_fun,lambda0,options);
rho = max_lambda_quest + trace(B);

% disp('solution of quest equation');
max_lambda_quest

% disp('estimated quaternion - quest algoirhtm');

% Markley text book convention - scalar last quaternion
% q_quest = [adjoint(rho*eye(3)-S)*z; det(rho*eye(3)-S)];

% MATLAB quaternion convention - scalar first quaternion
q_quest = [det(rho*eye(3)-S); adjoint(rho*eye(3)-S)*z]';
q_quest = q_quest / norm(q_quest)


toc

