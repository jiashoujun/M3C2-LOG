clear;clc
 
correspond = load('...\correspond.txt');
data2013 = load('...\NC_T1.txt');
data2017 = load('...\NC_T2.txt');

XYZ = correspond(:,1:3);
XYZ2013 = data2013(:,1:3);
XYZ2017 = data2017(:,1:3);
N2013 = data2013(:,4:6);
N2017 = data2017(:,4:6);

Q2013 = data2013(:,7);
Q2017 = data2017(:,7);

scale = correspond(:,4);
scale(isnan(scale))=0;

IndQ2013 = rangesearch(XYZ2013,XYZ2013,0.5*mean(scale));
IndQ2017 = rangesearch(XYZ2017,XYZ2017,0.5*mean(scale));
LQ2013 = cellfun(@length,IndQ2013,'uni',true);
LQ2017 = cellfun(@length,IndQ2017,'uni',true);

radii = 3;
Ind2013 = knnsearch(XYZ2013,XYZ2013,'Distance','euclidean','NSMethod','kdtree','K',radii);
Idx2013 = num2cell(Ind2013,2);
C2013 = cellfun(@(idx)mean(XYZ2013(idx,:),1),Idx2013,'uni',false);
C2013 = cell2mat(C2013);
D2013 = cellfun(@(idx)1./sqrt(sum((XYZ2013(idx(2:radii),:)-XYZ2013(idx(1),:)).^2,2))/sum(1./sqrt(sum((XYZ2013(idx(2:radii),:)-XYZ2013(idx(1),:)).^2,2))),Idx2013,'uni',false);
W2013 = reshape(cell2mat(D2013),radii-1,[]);
W2013 = W2013';

idW = num2cell((1:length(W2013))');
% N2013E = cellfun(@(idx,id)(N2013(idx(1),:) + W2013(id,1).*N2013(idx(2),:)+ W2013(id,2).*N2013(idx(3),:)+ W2013(id,3).*N2013(idx(4),:)+ W2013(id,4).*N2013(idx(5),:)+ W2013(id,5).*N2013(idx(6),:)+ W2013(id,6).*N2013(idx(7),:)),Idx2013,idW,'uni',false);   %%%%%%%%KNN
N2013E = cellfun(@(idx,id)(N2013(idx(1),:) + W2013(id,1).*N2013(idx(2),:) + W2013(id,2).*N2013(idx(3),:)),Idx2013,idW,'uni',false);
N2013E = cell2mat(N2013E);
% N2013EE = cellfun(@(idx,id)(N2013(idx(1),:) + W2013(id,1).*N2013E(idx(2),:) + W2013(id,2).*N2013E(idx(3),:) + W2013(id,3).*N2013E(idx(4),:) + W2013(id,4).*N2013E(idx(5),:) + W2013(id,5).*N2013E(idx(6),:) + W2013(id,6).*N2013E(idx(7),:)),Idx2013,idW,'uni',false);     %%%%%%%%KNN
N2013EE = cellfun(@(idx,id)(N2013(idx(1),:) + W2013(id,1).*N2013E(idx(2),:) + W2013(id,2).*N2013E(idx(3),:)),Idx2013,idW,'uni',false);
N2013EE = cell2mat(N2013EE);


F2013 = cellfun(@(idx)acos(dot([N2013(idx(2:radii),:)]',repmat([N2013(idx(1),:)]',1,radii-1))),Idx2013,'uni',false);
F2013 = abs(cell2mat(F2013));
F2013E = F2013(:,1:radii-1).*W2013;
F2013E = sum(F2013E,2);
F2013EE = cellfun(@(idx)F2013E(idx),Idx2013,'uni',false);
F2013EE = reshape(cell2mat(F2013EE),radii,[]);
F2013EE = F2013EE';
F2013EE = [F2013EE(:,1) F2013EE(:,2:radii).*W2013];
F2013EE = sum(F2013EE,2);


Ind2017 = knnsearch(XYZ2017,XYZ2017,'Distance','euclidean','NSMethod','kdtree','K',radii);
Idx2017 = num2cell(Ind2017,2);
D2017 = cellfun(@(idx)1./sqrt(sum((XYZ2017(idx(2:radii),:)-XYZ2017(idx(1),:)).^2,2))/sum(1./sqrt(sum((XYZ2017(idx(2:radii),:)-XYZ2017(idx(1),:)).^2,2))),Idx2017,'uni',false);
W2017 = reshape(cell2mat(D2017),radii-1,[]);
W2017 = W2017';

idW = num2cell((1:length(W2017))');
% N2017E = cellfun(@(idx,id)(N2017(idx(1),:) + W2017(id,1).*N2017(idx(2),:) + W2017(id,2).*N2017(idx(3),:) + W2017(id,3).*N2017(idx(4),:) + W2017(id,4).*N2017(idx(5),:) + W2017(id,5).*N2017(idx(6),:) + W2017(id,6).*N2017(idx(7),:)),Idx2017,idW,'uni',false);     %%%%%%%%KNN
N2017E = cellfun(@(idx,id)(N2017(idx(1),:) + W2017(id,1).*N2017(idx(2),:) + W2017(id,2).*N2017(idx(3),:)),Idx2017,idW,'uni',false);
N2017E = cell2mat(N2017E);


F2017 = cellfun(@(idx)acos(dot([N2017(idx(2:radii),:)]',repmat([N2017(idx(1),:)]',1,radii-1))),Idx2017,'uni',false);
F2017 = abs(cell2mat(F2017));
F2017E = F2017(:,1:radii-1).*W2017;
F2017E = sum(F2017E,2);


IndC2017 = knnsearch(XYZ2017,XYZ,'Distance','euclidean','NSMethod','kdtree','K',radii);
IdxC2017 = num2cell(IndC2017,2);
idXYZ = num2cell((1:length(XYZ))');
% C2017 = cellfun(@(idx,id)(XYZ2017(idx(1),:)+XYZ2017(idx(2),:)+XYZ2017(idx(3),:)+XYZ2017(idx(4),:)+XYZ2017(idx(5),:)+XYZ2017(idx(6),:)+XYZ2017(idx(7),:)+XYZ(id,:))./(radii+1),IdxC2017,idXYZ,'uni',false);  %%%%%%%%KNN
C2017 = cellfun(@(idx,id)(XYZ2017(idx(1),:)+XYZ2017(idx(2),:)+XYZ2017(idx(3),:)+XYZ(id,:))./(radii+1),IdxC2017,idXYZ,'uni',false);
C2017 = cell2mat(C2017);

DC2017 = cellfun(@(idx)1./sqrt(sum((XYZ2017(idx(2:radii),:)-XYZ2017(idx(1),:)).^2,2))/sum(1./sqrt(sum((XYZ2017(idx(2:radii),:)-XYZ2017(idx(1),:)).^2,2))),IdxC2017,'uni',false);
WC2017 = reshape(cell2mat(DC2017),radii-1,[]);
WC2017 = WC2017';

idWC = num2cell((1:length(WC2017))');
% N2017EE = cellfun(@(idx,id)(N2017(idx(1),:) + WC2017(id,1).*N2017E(idx(2),:) + WC2017(id,2).*N2017E(idx(3),:) + WC2017(id,3).*N2017E(idx(4),:) + WC2017(id,4).*N2017E(idx(5),:) + WC2017(id,5).*N2017E(idx(6),:) + WC2017(id,6).*N2017E(idx(7),:)),IdxC2017,idWC,'uni',false);   %%%%%%%%KNN
N2017EE = cellfun(@(idx,id)(N2017(idx(1),:) + WC2017(id,1).*N2017E(idx(2),:) + WC2017(id,2).*N2017E(idx(3),:)),IdxC2017,idWC,'uni',false);
N2017EE = cell2mat(N2017EE);

F2017EE = cellfun(@(idx)F2017E(idx),IdxC2017,'uni',false);
F2017EE = reshape(cell2mat(F2017EE),radii,[]);
F2017EE = F2017EE';
F2017EE = [F2017EE(:,1) F2017EE(:,2:radii).*WC2017];
F2017EE = sum(F2017EE,2);


ind =  isnan(Q2013);
Q2013(ind)=0;
ind =  isnan(Q2017);
Q2017(ind)=0;


d = C2017-XYZ2013;
lab = d(:,3)./abs(d(:,3));
dis = sqrt(sum(d'.^2));
DisD = lab.*dis';

DisNN = acos(dot(N2013EE',N2017EE')./(sqrt(sum((N2013EE.^2),2)).*sqrt(sum((N2017EE.^2),2)))');
DisFF = abs(F2017EE - F2013EE);
w = 1;
DisNFA = abs(w*DisNN') + abs((1-w)*DisFF);
DisNF = lab.*DisNFA;

DisN = lab.*DisNN';
DisF = lab.*DisFF;

DisNN1 = acos(dot(N2013',[N2017(IndC2017(:,1),:)]')./(sqrt(sum((N2013.^2),2)).*sqrt(sum(([N2017(IndC2017(:,1),:)].^2),2)))');
DisFF1 = abs(F2017(IndC2017(:,1),1) - F2013(:,1));
DisNFA1 = abs(w*DisNN1') + abs((1-w)*DisFF1);
DisNF1 = lab.*DisNFA1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Significant changes
%%%%%%%%%%%%%%%%%%%%%%%%%% Orientation Uncertainty
P_UN = 1*1.96*sqrt(Q2013.*Q2013./LQ2013 + Q2017(IndC2017(:,1)).*Q2017(IndC2017(:,1))./LQ2017(IndC2017(:,1)));
% P_UN = 1*1.96*sqrt(Q2013.*Q2013./LQ2017(IndC2017(:,1)) + Q2017(IndC2017(:,1)).*Q2017(IndC2017(:,1))./LQ2017(IndC2017(:,1)));
sigPN = DisNF1 - P_UN;
indSigPN = find(sigPN >= 0);
indNoSigPN = setdiff([1:length(sigPN)]',indSigPN);
PN_sig = length(indSigPN)/length(sigPN);

PUN = cellfun(@(idx)[P_UN(idx(:,2)) P_UN(idx(:,3))],Idx2013,'uni',false);
PUN = abs(cell2mat(PUN));
PUNE = PUN(:,1:radii-1).*W2013;
PUNE = sum(PUNE,2);
PUNEE = cellfun(@(idx)PUNE(idx),Idx2013,'uni',false);
PUNEE = reshape(cell2mat(PUNEE),radii,[]);
PUNEE = PUNEE';
PUNEE = [PUNEE(:,1) PUNEE(:,2:radii).*W2013];
G_UN = sum(PUNEE,2);
sigGN = DisNFA - G_UN;
indSigGN = find(sigGN >= 0);
indNoSigGN = setdiff([1:length(sigGN)]',indSigGN);
GN_sig = length(indSigGN)/length(sigGN);


%%%%%%%%%%%%%%%%%%%%%%%%%% Location Uncertainty
RegError = 0.2;   %%%%%%%%%%%%%%  need to change
P_UL = correspond(:,6) + 1.96*RegError;
sigPD = abs(correspond(:,7)) -  P_UL;
indSigPD = find(sigPD >= 0);
indNoSigPD = setdiff([1:length(sigPD)]',indSigPD);
PD_sig = length(indSigPD)/length(sigPD);

G_UL = cellfun(@(idx)mean(P_UL(idx,:),1),Idx2013,'uni',false);
G_UL = cell2mat(G_UL);
sigGD = abs(DisD) - G_UL;
indSigGD = find(sigGD >= 0);
indNoSigGD = setdiff([1:length(sigGD)]',indSigGD);
GD_sig = length(indSigGD)/length(sigGD);

%%%%%%%%%%%%%%%%%%%%%%%%%% Location and Orientation
indSigAll = [indSigGN;indSigGD];
indSigAll = unique(indSigAll);
indNoSigAll = setdiff([1:length(sigGD)]',indSigAll);
All_sig = length(indSigAll)/length(sigGD);

Aresult = [PD_sig GD_sig PN_sig GN_sig All_sig]



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Save results


