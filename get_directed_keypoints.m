function [features] = get_directed_keypoints(keypoints, gauss_pyr, intvls, init_sigma)
%GET_DIRECTED_KEYPOINTS 此处显示有关此函数的摘要
%   此处显示详细说明

% determines gaussian sigma for orientation assignment
sift_ori_sig_factr = 1.5;
% number of bins in histogram
sift_ori_hist_bins = 36;
% orientation magnitude relative to max that results in new feature
sift_ori_peak_ratio = 0.8;
% number of passes of orientation histogram smoothing
sift_ori_smooth_passes = 2;
% array of feature
features = struct('ddata_index',0,'x',0,'y',0,'scl',0,'ori',0,'descr',[]);
feat_index = 1;

n = size(keypoints,2);

for i = 1:n
    ddata = keypoints(i);
    ori_sigma = sift_ori_sig_factr * ddata.scl_octv;
    % generate a histogram for the gradient distribution around a keypoint
    hist = ori_hist(gauss_pyr{ddata.octv}(:,:,ddata.intvl),ddata.x,ddata.y,sift_ori_hist_bins,round(3*ori_sigma),ori_sigma);
    for j = 1:sift_ori_smooth_passes
        hist = smooth_ori_hist(hist,sift_ori_hist_bins);
    end
    hist_max = max(hist); % this is the dominant orientation
    % generate feature from ddata and orientation hist peak
    % add orientations greater than or equal to 80% of the largest orientation magnitude
    [features, feat_index] = add_good_ori_features(i,features,feat_index,ddata,hist,sift_ori_hist_bins,hist_max*sift_ori_peak_ratio,intvls,init_sigma);
end
end

