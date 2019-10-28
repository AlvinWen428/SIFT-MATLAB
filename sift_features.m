function [descrs,locs,oris,scls] = sift_features(img, intvls, init_sigma, contr_thr, curv_thr)
%SIFT_FEATURES ��ͼƬ����ȡ�ؼ��������Ӻ͹ؼ����λ�ã��ù�����Ҫ
%�ȹ�����˹��ֽ�������
%Ȼ����ؼ��㣬ȥ�����ȶ��Ĺؼ��㣬
%���������
%���������ӵ�����
% input:  img: ����ͼƬ, intvls����������ÿ���ͼƬ��, init_sigma����ʼ����sigma,
% contr_thr: �Աȶ���ֵ
% curv_thr: ��������ֵ
% outputs:  descr�����������������   loc���ؼ����λ��

%%%%%%%%%%%%%%%%%%%%%%%% initialize the parameters %%%%%%%%%%%%%%%%%%%%%%%%
if ~exist('intvls', 'var') || isempty(intvls)
    % intvls ����Ϊ�գ����߲��Ա�������ʽ���ڣ�
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

