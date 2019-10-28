function [hist] = smooth_ori_hist(hist,n)
%SMOOTH_ORI_HIST 此处显示有关此函数的摘要
%   此处显示详细说明
h0 = hist(1);
prev = hist(n);
for i = 1:n
    tmp = hist(i);
    if (i==n)
        hist(i) = 0.25*prev + 0.5*hist(i) + 0.25*h0;
    else
        hist(i) = 0.25*prev + 0.5*hist(i) + 0.25*hist(i+1);
    end
    prev = tmp;
end
end

