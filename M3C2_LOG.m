clear
clc

corrPoint = load('');    %%%%%  corrPoint can be found based on normal direction, vertical direction, or closest points
dataT1 = load('');
dataT2 = load('');

XYZ = M3C2(:,1:3);
T1 = dataT1(:,1:3);
T2 = dataT2(:,1:3);

Norm1 = dataT1(:,5:7);
Norm2 = dataT2(:,5:7);

R = 4;
Ind1 = num2cell(knnsearch(T1,T1,'Distance','euclidean','NSMethod','kdtree','K',R),2);
W1 = cellfun(@(Ind) 1./sqrt(sum((T1(Ind(2:R),:)-T1(Ind(1),:)).^2,2))/sum(1./sqrt(sum((T1(Ind(2:R),:)-T1(Ind(1),:)).^2,2))),Ind1,'uni',false);

C1 = cellfun(@(Ind) 0.5*(T1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*T1(Ind(2:R),:))),Ind1,'uni',false);
C1 = cell2mat(C1);
G1 = cellfun(@(Ind) 0.5*(T1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*C1(Ind(2:R),:))),Ind1,'uni',false);
G1 = cell2mat(G1);

N1 = cellfun(@(Ind) 0.5*(Norm1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*Norm1(Ind(2:R),:))),Ind1,'uni',false);
N1 = cell2mat(N1);
F1 = cellfun(@(Ind) 0.5*(Norm1(Ind(1),:) + sum(cell2mat(W1(Ind(1))).*N1(Ind(2:R),:))),Ind1,'uni',false);
F1 = cell2mat(F1);



Ind2 = num2cell(knnsearch(T2,T2,'Distance','euclidean','NSMethod','kdtree','K',R),2);
W2 = cellfun(@(Ind) 1./sqrt(sum((T2(Ind(2:R),:)-T2(Ind(1),:)).^2,2))/sum(1./sqrt(sum((T2(Ind(2:R),:)-T2(Ind(1),:)).^2,2))),Ind2,'uni',false);

C2 = cellfun(@(Ind) 0.5*(T2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*T2(Ind(2:R),:))),Ind2,'uni',false);
C2 = cell2mat(C2);
G2 = cellfun(@(Ind) 0.5*(T2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*C2(Ind(2:R),:))),Ind2,'uni',false);
G2 = cell2mat(G2);

N2 = cellfun(@(Ind) 0.5*(Norm2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*Norm2(Ind(2:R),:))),Ind2,'uni',false);
N2 = cell2mat(N2);
F2 = cellfun(@(Ind) 0.5*(Norm2(Ind(1),:) + sum(cell2mat(W2(Ind(1))).*N2(Ind(2:R),:))),Ind2,'uni',false);
F2 = cell2mat(F2);


[IndKNN,~] = knnsearch(T2,XYZ,'Distance','euclidean','NSMethod','kdtree','K',1);


dP = T2(IndKNN,:)-T1;
PointD = sqrt(sum(dP.^2,2));

dG = G2(IndKNN,:)-G1;
GraphD = sqrt(sum(dG.^2,2));

dF = acos(dot(F1',[F2(IndKNN,:)]')./(sqrt(sum((F1.^2),2)).*sqrt(sum(([F2(IndKNN,:)].^2),2)))');
GraphF = dF';

lab = dG(:,3)./abs(dG(:,3));


fid=fopen('PointD.txt','w');
fprintf(fid,'%10.3f %10.3f %10.3f %10.3f\n',[T1 lab.*PointD]');
fclose(fid);

fid=fopen('GraphD.txt','w');
fprintf(fid,'%10.3f %10.3f %10.3f %10.3f\n',[T1 lab.*GraphD]');
fclose(fid);

fid=fopen('GraphF.txt','w');
fprintf(fid,'%10.3f %10.3f %10.3f %10.3f\n',[T1 lab.*GraphF]');
fclose(fid);






