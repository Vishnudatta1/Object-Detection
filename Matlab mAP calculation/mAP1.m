clc; clear all; close all;
s=load('camfront_nuscenes_detection.mat');
s1=s.data1;
gt=struct2table(s1);
pred=readtable('ssd_predictions.xlsx');
pred = sortrows(pred,'Label','ascend');
pred(797:805,:) = [];
gt = sortrows(gt,'category_name','ascend');
gt(1142:2314,:) = [];
gt(3757:4021,:) = [];
pred(797:798,:) = [];
for c = 1:1141
     gt.category_name{c} = 'person';
end
for d = 1142:1223
     gt.category_name{d} = 'bicycle';
end
for e = 1224:1405
     gt.category_name{e} = 'bus';
end
for f = 1406:3756
     gt.category_name{f} = 'car';
end
for g = 3757:3946
     gt.category_name{g} = 'truck';
end
gt.Properties.VariableNames{1} = 'ObjectLocation';
gt.Properties.VariableNames{2} = 'Label';
gt.Properties.VariableNames{3} = 'Filename';
gt = sortrows(gt,'visibility_token','ascend');
gt(1:1955,:) = [];
gt = sortrows(gt,'Filename','ascend');
gt = removevars(gt, 'visibility_token');
pred = sortrows(pred,'Filename','ascend');
gt = sortrows(gt,'Filename','ascend');
gt.Properties.VariableNames{1} = 'boxes';
gt.Properties.VariableNames{2} = 'labels';
pred.Properties.VariableNames{1} = 'boxes';
pred.Properties.VariableNames{2} = 'scores';
pred.Properties.VariableNames{3} = 'labels';
for i=1:855
    pred.scores{i}=str2num(pred.scores{i});
end
for i=1:855
    pred.boxes{i}=str2num(pred.boxes{i});
    pred.scores{i}=(pred.scores{i})/100;
    pred.labels{i}=string(pred.labels{i});
end
%pred.labels=categorical(pred.labels);
for i=1:1991
    gt.boxes{i}=transpose(gt.boxes{i});
    gt.labels{i}=string(gt.labels{i});
end
limit2=1991;
for i=2:limit2
    a=gt.boxes{i-1};
    c=gt.labels{i-1};
    j=0;
    k=i;
    while gt.Filename{k}==gt.Filename{k-1}
        j=j+1;
        a=[a;gt.boxes{k}];
        c=[c;gt.labels{k}];
        k=k+1;
        %gt.boxes{k-1}=[gt.boxes{k-1};gt.boxes{k}];
        %gt.labels{k-1}=[gt.labels{k-1};gt.labels{k}];
        %gt(k,:)=[];
        %limit2=limit2-1;
        if k>limit2
            break;
        end;
    end
    if j>=1
        gt(i:i+j-1,:) = [];
        gt.boxes{i-1}=a;
        gt.labels{i-1}=c;
        limit2=limit2-j;
    end
end
% limit=855;
% for i=2:limit
%     a=pred.boxes{i-1};
%     b=pred.scores{i-1};
%     c=pred.labels{i-1};
%     j=0;
%     k=i;
%     while pred.Filename{k}==pred.Filename{k-1}
%         j=j+1;
%         a=[a;pred.boxes{k}];
%         b=[b;pred.scores{k}];
%         c=[c;pred.labels{k}];
%         k=k+1;
%         if (k>limit)
%             break;
%         end
%     end
%     if j>=1
%         pred(i:i+j-1,:) = [];
%         pred.boxes{i-1}=a;
%         pred.scores{i-1}=b;
%         pred.labels{i-1}=c;
%         limit=limit-j;
%     end
% end

%blds = boxLabelDatastore(gt(:,2:end));
%imds = imageDatastore(pred.Filename);
%[ap, recall, precision] = evaluateDetectionPrecision(pred, gt);