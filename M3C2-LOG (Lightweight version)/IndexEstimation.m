function [IndT1] = IndexEstimation(P1, scale)

NS1 = createns(P1,'NSMethod','kdtree');
IndT1 = rangesearch(NS1,P1,scale);

NumP1 = cellfun('length',IndT1);
IndSpaT1 = find(NumP1<11);

[~,DisT1] = knnsearch(NS1,P1,'K',11);
ScaleT1 = ceil(DisT1(:,11));

Mscale1 = max(ScaleT1);

if Mscale1>scale
    for i = scale:Mscale1
        
        if isempty(IndSpaT1)
            break
        end
        
        tmp = rangesearch(NS1,P1(IndSpaT1,:),i+1);
        IndT1(IndSpaT1) = tmp;
        
        NumP1 = cellfun('length',IndT1(IndSpaT1));
        IndSpaT1 = IndSpaT1(NumP1<11);
        
    end
end



end





