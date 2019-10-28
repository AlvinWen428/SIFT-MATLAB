function [feat] = hist_to_descr(feat,descr,descr_mag_thr)
%HIST_TO_DESCR 此处显示有关此函数的摘要
%   此处显示详细说明

descr = descr/norm(descr);
descr = min(descr_mag_thr,descr);
descr = descr/norm(descr);
feat.descr = descr;
end