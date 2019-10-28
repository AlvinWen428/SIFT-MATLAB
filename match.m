function [matched] = match(descr1,descr2,dist_thr)
%MATCH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

[n1, dim1] = size(descr1);
[n2, dim2] = size(descr2);

if (dim1~=dim2)
    disp('Two dimensions should be equal!');
    matched = -1;
    return
else
    matched = zeros(2,min(n1,n2));
    index = 1;
    for i = 1:n1
        min_distance = sqrt(sum((descr1(i,:)-descr2(1,:)).^2));
        min_loc2 = 1;
        for j = 2:n2
            s = sqrt(sum((descr1(i,:)-descr2(j,:)).^2));
            if (s<min_distance)
                min_distance = s;
                min_loc2 = j;
            end
        end
        if (min_distance<dist_thr)
            matched(1,index) = i;
            matched(2,index) = min_loc2;
            index = index + 1;
        end
    end
end
matched(:,find(sum(abs(matched),1)==0))=[];
end

