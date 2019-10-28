clear

% The threshold of the Euclidean distance of two feature vectors
dist_thr = 0.5;

img1 = imread('../img1.bmp');
img1_rotate = imrotate(img1,90);
img1_small = imresize(img1,0.5,'bicubic');
img1_crop = imcrop(img1,[20,40,360,420]);
img1_noise = imnoise(img1,'gaussian');
img2 = imread('../img2.jpg');
[descr1, loc1, ori1, scl1] = sift_features(img1,3,1.6,0.07,2);
[descr_rotate1, loc_rotate1, ori_rotate1, scl_rotate1] = sift_features(img1_rotate,3,1.6,0.07,2);
[descr_small1, loc_small1, ori_small1, scl_small1] = sift_features(img1_small,3,1.6,0.07,2);
[descr_crop1, loc_crop1, ori_crop1, scl_crop1] = sift_features(img1_crop,3,1.6,0.07,2);
[descr_noise1, loc_noise1, ori_noise1, scl_noise1] = sift_features(img1_noise,3,1.6,0.07,2);
[descr2, loc2, ori2, scl2] = sift_features(img2,3,1.6,0.04,10);

matched_rotate = match(descr1, descr_rotate1, dist_thr);
matched_small = match(descr1, descr_small1, dist_thr);
matched_crop = match(descr1, descr_crop1, dist_thr);
matched_noise = match(descr1, descr_noise1, dist_thr);

draw_features(img1, loc1, ori1, scl1, 1);
draw_features(img1_rotate, loc_rotate1, ori_rotate1, scl_rotate1, 2);
draw_features(img1_small, loc_small1, ori_small1, scl_small1, 3);
draw_features(img1_crop, loc_crop1, ori_crop1, scl_crop1, 4);
draw_features(img1_noise, loc_noise1, ori_noise1, scl_noise1, 5);
% draw_features(img2, loc2, ori2, scl2, 4);
draw_matched(matched_rotate, img1, img1_rotate, loc1, loc_rotate1, 6);
draw_matched(matched_small, img1, img1_small, loc1, loc_small1, 7);
draw_matched(matched_crop, img1, img1_crop, loc1, loc_crop1, 8);
draw_matched(matched_noise, img1, img1_noise, loc1, loc_noise1, 9);