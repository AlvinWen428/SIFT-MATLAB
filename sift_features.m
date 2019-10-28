function [descrs,locs,oris,scls] = sift_features(img, intvls, init_sigma, contr_thr, curv_thr)
%SIFT_FEATURES 从图片中提取关键点描述子和关键点的位置，该过程需要
%先构建高斯差分金字塔，
%然后检测关键点，去除不稳定的关键点，
%获得主方向，
%生成描述子的向量
% input:  img: 输入图片, intvls：降采样后每组的图片数, init_sigma：初始化的sigma,
% contr_thr: 对比度阈值
% curv_thr: 主曲率阈值
% outputs:  descr：输出的描述子向量   loc：关键点的位置

%%%%%%%%%%%%%%%%%%%%%%%% initialize the parameters %%%%%%%%%%%%%%%%%%%%%%%%
if ~exist('intvls', 'var') || isempty(intvls)
    % intvls 参数为空，或者不以变量的形式存在；
    intvls = 3;
end
if ~exist('init_sigma', 'var') || isempty(init_sigma)
    init_sigma = 1.6;
end
if ~exist('contr_thr', 'var') || isempty(contr_thr)
    contr_thr = 0.04;
end
if ~exist('curv_thr', 'var') || isempty(curv_thr)
    curv_thr =10;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% transform the rgb to gray, and normalize it
if(size(img,3)==3)
    img = rgb2gray(img);
end
img = im2double(img);

% default cubic method
img = imresize(img,2);
% assume the original image has a blur of sigma = 0.5
img = gaussian(img,sqrt(init_sigma^2-0.5^2*4));
% smallest dimension of top level is about 8 pixels
octvs = floor(log(min(size(img)))/log(2) - 2);

% build Pyramid
[gauss_pyr, dog_pyr] = build_pyr(img, octvs, intvls, init_sigma);

% find the currect keypoints and remove the unstable keypoints
keypoints = get_keypoints(dog_pyr, octvs, intvls, contr_thr, curv_thr, init_sigma);

% assign the directions for each keypoints, called features
features = get_directed_keypoints(keypoints, gauss_pyr, intvls, init_sigma);

% generate the discriptors
[descrs, locs, oris, scls] = compute_discriptors(features, keypoints, gauss_pyr);

end

