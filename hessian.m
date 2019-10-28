function [result] = hessian(dog_img_list, intvl, x, y)
%HESSIAN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
center = dog_img_list(x,y,intvl);
dxx = dog_img_list(x+1,y,intvl) + dog_img_list(x-1,y,intvl) - 2*center;
dyy = dog_img_list(x,y+1,intvl) + dog_img_list(x,y-1,intvl) - 2*center;
dss = dog_img_list(x,y,intvl+1) + dog_img_list(x,y,intvl-1) - 2*center;

dxy = (dog_img_list(x+1,y+1,intvl)+dog_img_list(x-1,y-1,intvl)-dog_img_list(x+1,y-1,intvl)-dog_img_list(x-1,y+1,intvl))/4;
dxs = (dog_img_list(x+1,y,intvl+1)+dog_img_list(x-1,y,intvl-1)-dog_img_list(x+1,y,intvl-1)-dog_img_list(x-1,y,intvl+1))/4;
dys = (dog_img_list(x,y+1,intvl+1)+dog_img_list(x,y-1,intvl-1)-dog_img_list(x,y-1,intvl+1)-dog_img_list(x,y+1,intvl-1))/4;

result = [dxx,dxy,dxs;dxy,dyy,dys;dxs,dys,dss];
end

