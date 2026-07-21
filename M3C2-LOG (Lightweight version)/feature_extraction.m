
function [n1,n2,n3] = feature_extraction(Point,IndT)

% N = length(Point);
% IndR = (1:N)';
% srcData = Point';
% srcSeed = Point(IndR,:)';

% % xyzIdx = IndT;
% % idxSz = cellfun(@length,xyzIdx,'uni',true);
% % M = length(idxSz);
% % idx = num2cell((1:M)');
% 
% idx = num2cell((1:N)',2);
% [n1,n2,n3] = cellfun(@(x,y)svdCov(x,y,srcData,srcSeed),IndT,idx,'uni',false);

N = length(Point);
srcData = Point';          % Nx3
srcSeed = Point((1:N)',:)';
n1 = cell(N,1);
n2 = cell(N,1);
n3 = cell(N,1);

for i = 1:N
    idx = IndT{i};   % kx1
    [v1,v2,v3] = svdCov(idx, i, srcData, srcSeed);
    n1{i} = v1;
    n2{i} = v2;
    n3{i} = v3;
end


end



