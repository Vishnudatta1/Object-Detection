limit=855;
for i=2:limit
    a=pred.boxes{i-1};
    b=pred.scores{i-1};
    c=pred.labels{i-1};
    j=0;
    k=i;
    while pred.Filename{k}==pred.Filename{k-1}
        j=j+1;
        a=[a;pred.boxes{k}];
        b=[b;pred.scores{k}];
        c=[c;pred.labels{k}];
        k=k+1;
        if (k>limit)
            break;
        end
    end
    if j>=1
        pred(i:i+j-1,:) = [];
        pred.boxes{i-1}=a;
        pred.scores{i-1}=b;
        pred.labels{i-1}=c;
        limit=limit-j;
    end
end