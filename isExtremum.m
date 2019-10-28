function [result] = isExtremum(dog_img_list, intvl, x, y)
%ISEXTREMUM 此处显示有关此函数的摘要
%   此处显示详细说明
value = dog_img_list(x,y,intvl);
block = dog_img_list(x-1:x+1,y-1:y+1,intvl-1:intvl+1);
if ( value > 0 && value == max(block(:)) )
    result = 1;
elseif ( value == min(block(:)) )
    result = 1;
else
    result = 0;
end

end