function [] = draw_matched(matched, img1, img2, loc1, loc2, figure_num)
%DRAW_MATCHED 此处显示有关此函数的摘要
%   此处显示详细说明
figure(figure_num);

size1 = size(img1);
size2 = size(img2);
if (size1(1) < size2(1))
    img1(size2(1),:) = 0;
elseif (size1(1) > size2(1))
    img2(size1(1),:) = 0;
end
merge_img = [img1 img2];
imshow(merge_img);
hold on;

[~,n] = size(matched);
for i = 1:n
    color = rand(1,3);
    plot(loc1(matched(1,i),2),loc1(matched(1,i),1),'o','Color',color);
    plot(loc2(matched(2,i),2)+size1(1),loc2(matched(2,i),1),'o','Color',color);
    plot([loc1(matched(1,i),2) loc2(matched(2,i),2)+size1(1)], [loc1(matched(1,i),1) loc2(matched(2,i),1)], 'Color',color,'LineWidth',0.5);
end
end

