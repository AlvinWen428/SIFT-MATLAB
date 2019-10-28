function [result] = is_too_edge_like(dog_img, x, y, curv_thr)
%IS_TOO_EDGE_LIKE 此处显示有关此函数的摘要
%   此处显示详细说明

d = dog_img(x,y);
dxx = dog_img(x,y+1) + dog_img(x,y-1) - 2*d;
dyy = dog_img(x+1,y) + dog_img(x-1,y) - 2*d;
dxy = (dog_img(x+1,y+1) - dog_img(x+1,y-1) - dog_img(x-1,y+1) + dog_img(x-1,y-1)) / 4;
tr = dxx + dyy;
det = dxx * dyy - dxy * dxy;
if ( det <= 0 )
    result = 1;
    return;
end
if ( tr*tr / det < (curv_thr + 1)^2 / curv_thr )
    result = 0;
else
    result = 1;
end
end

