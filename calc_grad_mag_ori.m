function [mag, ori, flag] = calc_grad_mag_ori(img,x,y)
%CALC_GRAD_MAG_ORI 此处显示有关此函数的摘要
%   此处显示详细说明
[height,width] = size(img);
if (x > 1 && x < height && y > 1 && y < width)
    dx = img(x,y+1) - img(x,y-1);
    dy = img(x+1,y) - img(x-1,y);
    mag = sqrt(dx^2+dy^2);
    ori = atan2(dx,dy);
    flag = 1;
else
    mag = -1;
    ori = -1;
    flag = 0;
end

