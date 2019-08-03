function s = randnum(mu,Sigma,K)
if (size(mu,2)==1)
    mu=mu';
end
 
if nargin==3
    mu=repmat(mu,K,1);
end
 
[n,d]=size(mu);
 
 
try
    U=chol(Sigma);
catch
    [E,Lambda]=eig(Sigma);
    if (min(diag(Lambda))<0),error('Sigma must be positive semi-definite.'),end
    U = sqrt(Lambda)*E';
end
 
s = randn(n,d)*U + mu;
s = s';
