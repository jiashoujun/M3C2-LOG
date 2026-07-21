clear
clc
close all

%% data input

dataT1 = load('data\T1.txt');   %%% 3D point cloud Epoch 1 // (X Y Z)
dataT2 = load('data\T2.txt');   %%% 3D point cloud Epoch 2 // (X Y Z)
corrPoint = load('data\Correspondence.txt');   %%% Correspondence points of Epoch 1 in Epoch 2 (this could be from M3C2) 

T1 = dataT1(:,1:3);
T2 = dataT2(:,1:3);
corrPoint = corrPoint(:,1:3);

%%  Parameter setting

scale = 2;  %%% neighborhood radius for computing normal vectors
R = 4;   %%% K-nearest neighbors (KNN) for hierarchical graph aggregation (Recommendation value 3 - 6)

%% Calculation of normal vectors (this step can be displaced if you have better way, i.e., compute normal vector from CloudCompare)

IndT1 = IndexEstimation(T1, scale);
IndT2 = IndexEstimation(T2, scale);
[~,~,N3T1] = feature_extraction(T1,IndT1);
[~,~,N3T2] = feature_extraction(T2,IndT2);

Norm1 = cell2mat(N3T1);
Norm2 = cell2mat(N3T2);


%%  Hierarchical graph aggregation

Ind1 = num2cell(knnsearch(T1,T1,'Distance','euclidean','NSMethod','kdtree','K',R),2);
W1 = cellfun(@(Ind) 1./sqrt(sum((T1(Ind(2:R),:)-T1(Ind(1),:)).^2,2))/sum(1./sqrt(sum((T1(Ind(2:R),:)-T1(Ind(1),:)).^2,2))),Ind1,'uni',false);

C1 = cell2mat(cellfun(@(Ind) 0.5*(T1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*T1(Ind(2:R),:))),Ind1,'uni',false));
G1 = cell2mat(cellfun(@(Ind) 0.5*(T1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*C1(Ind(2:R),:))),Ind1,'uni',false));

N1 = cell2mat(cellfun(@(Ind) 0.5*(Norm1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*Norm1(Ind(2:R),:))),Ind1,'uni',false));
F1 = cell2mat(cellfun(@(Ind) 0.5*(Norm1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*N1(Ind(2:R),:))),Ind1,'uni',false));



Ind2 = num2cell(knnsearch(T2,T2,'Distance','euclidean','NSMethod','kdtree','K',R),2);
W2 = cellfun(@(Ind) 1./sqrt(sum((T2(Ind(2:R),:)-T2(Ind(1),:)).^2,2))/sum(1./sqrt(sum((T2(Ind(2:R),:)-T2(Ind(1),:)).^2,2))),Ind2,'uni',false);

C2 = cell2mat(cellfun(@(Ind) 0.5*(T2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*T2(Ind(2:R),:))),Ind2,'uni',false));
G2 = cell2mat(cellfun(@(Ind) 0.5*(T2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*C2(Ind(2:R),:))),Ind2,'uni',false));


N2 = cell2mat(cellfun(@(Ind) 0.5*(Norm2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*Norm2(Ind(2:R),:))),Ind2,'uni',false));
F2 = cell2mat(cellfun(@(Ind) 0.5*(Norm2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*N2(Ind(2:R),:))),Ind2,'uni',false));

[IndKNN,~] = knnsearch(T2,corrPoint,'Distance','euclidean','NSMethod','kdtree','K',1);

%% Point cloud change estimation using graph comparison

dG = G2(IndKNN,:)-G1;
GraphD = sqrt(sum(dG.^2,2));

dF = acos(dot(F1',[F2(IndKNN,:)]')./(sqrt(sum((F1.^2),2)).*sqrt(sum(([F2(IndKNN,:)].^2),2)))');
GraphF = dF';

lable = sign(dG(:,3));


%% Output and save

fid=fopen('GraphD.txt','w');
fprintf(fid,'%10.3f %10.3f %10.3f %10.3f\n',[T1 lable.*GraphD]');
fclose(fid);

fid=fopen('GraphF.txt','w');
fprintf(fid,'%10.3f %10.3f %10.3f %10.3f\n',[T1 lable.*GraphF]');
fclose(fid);






