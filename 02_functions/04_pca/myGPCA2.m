function [U, eval]= myGPCA2(B, K, flag1, flag2)

% c = 100;
% ni = 3;
% 
% n = c*ni;
% p = n-c;
% M = create_M_matrix(ni*ones(1, c));
% L = eye(length(M))-M;

%B = (Z*M)*(Z*M)';
[evec, eval] = F_Eigen_f(B);
%[evec, eval] = eigs(B, size(Z, 1), 'LM');
p = min([length(eval), K]);
if flag1 == 0
    U = evec(:,1:p);
else
    U = evec(:,1:p)*diag(eval(1:p).^(-1/2));
end

% Weighting (done by Matlab, useful for AAMs)
if nargin > 3
if flag2 == 1
    U = U*diag(eval(1:p).^(1/2));
end

eval = eval(1:p);
end
