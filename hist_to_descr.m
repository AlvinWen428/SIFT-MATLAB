function [feat] = hist_to_descr(feat,descr,descr_mag_thr)
%HIST_TO_DESCR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

descr = descr/norm(descr);
descr = min(descr_mag_thr,descr);
descr = descr/norm(descr);
feat.descr = descr;
end