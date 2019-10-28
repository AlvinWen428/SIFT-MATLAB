function [descrs, locs, oris, scls] = compute_discriptors(features, keypoints, gauss_pyr)
%COMPUTE_DISCRIPTORS 此处显示有关此函数的摘要
%   此处显示详细说明

% number of features
n = size(features,2);
% width of 2d array of orientation histograms
sift_descr_width = 4;
% bins per orientation histogram
sift_descr_hist_bins = 8;
% threshold on magnitude of elements of descriptor vector
sift_descr_mag_thr = 0.2;

descr_length = sift_descr_width * sift_descr_width * sift_descr_hist_bins;

for feat_index = 1:n
    feat = features(feat_index);
    ddata = keypoints(feat.ddata_index);
    gauss_img = gauss_pyr{ddata.octv}(:,:,ddata.intvl);
    hist = descr_hist(gauss_img, ddata.x, ddata.y, feat.ori, ddata.scl_octv, sift_descr_width, sift_descr_hist_bins, descr_length);
    features(feat_index) = hist_to_descr(feat,hist,sift_descr_mag_thr);
end

% sort the descriptors by descending scale order
features_scl = [features.scl];
[~,features_order] = sort(features_scl,'descend');
% return descriptors and locations
descrs = zeros(n,descr_length);
locs = zeros(n,2);
oris = zeros(n,1);
scls = zeros(n,1);
for i = 1:n
    descrs(i,:) = features(features_order(i)).descr;
    locs(i,1) = features(features_order(i)).x;
    locs(i,2) = features(features_order(i)).y;
    oris(i) = features(features_order(i)).ori;
    scls(i) = features(features_order(i)).scl;
end

end