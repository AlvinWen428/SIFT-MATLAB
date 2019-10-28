function [] = draw_features(img,loc,ori,scl,figure_num)
%DRAW_FEATURES 此处显示有关此函数的摘要
%   此处显示详细说明
figure(figure_num);
imshow(img);
hold on;
[point_num,~] = size(loc);
for i = 1:point_num
    color = rand(3,1);
    viscircles([loc(i,2) loc(i,1)],scl(i),'Color',color,'LineWidth',0.5);
    x1 = loc(i,2) + scl(i)*sin(ori(i));
    y1 = loc(i,1) + scl(i)*cos(ori(i));
    plot([loc(i,2) x1], [loc(i,1) y1], 'Color',color,'LineWidth',0.5);
end

end

