function M = matrixCompute(A,xc)

% perform svd on the convarance matrix of the point set A
if(size(A,1)~=3)
   A = A'; 
end

% construct the convariance matrix
K = size(A,2);
D = sqrt(sum((A - xc).^2));
B = D.*bsxfun(@minus, A, xc(:));


M = 1/K*(B*B');

