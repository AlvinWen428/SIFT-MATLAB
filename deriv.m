function [result] = deriv(dog_img_list, intvl, x, y)
%DERIV 此处显示有关此函数的摘要
%   此处显示详细说明
dx = (dog_img_list(x+1,y,intvl) - dog_img_list(x-1,y,intvl))/2;
dy = (dog_img_list(x,y+1,intvl) - dog_img_list(x,y-1,intvl))/2;
ds = (dog_img_list(x,y,intvl+1) - dog_img_list(x,y,intvl-1))/2;
result = [dx,dy,ds]';
end

