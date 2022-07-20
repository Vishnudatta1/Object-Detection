%gt(402:end,:) = [];
% limit3=327;
% for i=1:limit3
%     if gt.Filename{i} ~= pred.Filename{i}
%         gt(i,:)=[];
%         i=i-1;
%         %limit3=limit3-1;
%     end
% end
%gt(329:end,:) = [];
% pred = removevars(pred, 'Filename');
% gt = removevars(gt, 'Filename');
gt2=gt;
pred2=pred;
gt2(25:end,:) = [];
pred2(25:end,:) = [];
pred2 = movevars(pred2, 'scores', 'Before', 'Filename');
pred2 = movevars(pred2, 'scores', 'Before', 'labels');
pred2 = removevars(pred2, 'Filename');
gt2 = removevars(gt2, 'Filename');
for l=1:24
    gt2.labels{l}=categorical(gt2.labels{l});
end
for l=1:24
    pred2.labels{l}=categorical(pred2.labels{l});
end
ap= evaluateDetectionPrecision(pred2, gt2);