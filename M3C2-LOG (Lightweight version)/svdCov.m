function [n1,n2,n3] = svdCov(nnIdx, idx, Data, Seed)

nnPt = Data(:,nnIdx);
C = matrixCompute(nnPt,Seed(:,idx));
[U,S,~] = svd(C);
lam=diag(S);
F1=(lam(1)-lam(2))/lam(1);
F2=(lam(2)-lam(3))/lam(1);
F3=(lam(1)-lam(3))/lam(1);
F4=lam(3)/sum(diag(S));
F5=lam(3)/lam(1);
F6=1/3*sum(diag(S));
F7=( F4 .* F5 .* F6 ).^(1/3);
F8=-(F4.*log(F4) + F5.*log(F5) +F6.*log(F6) );

s =[F1 F2 F3 F4 F5 F6 F7 F8];
% s = diag(S)/sum(diag(S));
n1 = sign(dot(U(:,1),-Seed(:,idx)))*U(:,1);
n2 = sign(dot(U(:,2),-Seed(:,idx)))*U(:,2);
n3 = sign(dot(U(:,3),-Seed(:,idx)))*U(:,3);

n1 = n1';
n2 = n2';
n3 = n3';

end


% [s,n] = cellfun(@(x,y)svdCov(x,y,tarData,tarSeed),tarIdx,idx,'uni',false);

