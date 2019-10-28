function [result] = hessian(dog_img_list, intvl, x, y)
%HESSIAN 此处显示有关此函数的摘要
%   此处显示详细说明
center = dog_img_list(x,y,intvl);
dxx = dog_img_list(x+1,y,intvl) + dog_img_list(x-1,y,intvl) - 2*center;
dyy = dog_img_list(x,y+1,intvl) + dog_img_list(x,y-1,intvl) - 2*center;
dss = dog_img_list(x,y,intvl+1) + dog_img_list(x,y,intvl-1) - 2*center;

dxy = (dog_img_list(x+1,y+1,intvl)+dog_img_list(x-1,y-1,intvl)-dog_img_list(x+1,y-1,intvl)-dog_img_list(x-1,y+1,intvl))/4;
dxs = (dog_img_list(x+1,y,intvl+1)+dog_img_list(x-1,y,intvl-1)-dog_img_list(x+1,y,intvl-1)-dog_img_list(x-1,y,intvl+1))/4;
dys = (dog_img_list(x,y+1,intvl+1)+dog_img_list(x,y-1,intvl-1)-dog_img_list(x,y-1,intvl+1)-dog_img_list(x,y+1,intvl-1))/4;

result = [dxx,dxy,dxs;dxy,dyy,dys;dxs,dys,dss];
end

