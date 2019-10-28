function [hist] = ori_hist(img, x, y, n, rad, sigma)
%ORI_HIST 此处显示有关此函数的摘要
%   此处显示详细说明

hist = zeros(n, 1);
exp_denom = 2.0 * sigma * sigma;
for i = -rad:rad
    for j = -rad:rad
        [mag, ori, flag] = calc_grad_mag_ori(img,x+i,y+j);
        if (flag==1)
            w = exp(-(i^2+j^2)/exp_denom);
            bin = 1 + round(n * (ori+pi) / (2*pi));
            if (bin>=n+1)
                bin = 1;
            end
            hist(bin) = hist(bin) + w * mag;
        end
    end
end
end

