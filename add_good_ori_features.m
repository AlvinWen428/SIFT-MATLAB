function [features, feat_index] = add_good_ori_features(ddata_index,features,feat_index,ddata,hist,n,mag_thr,intvls,init_sigma)
%ADD_GOOD_ORI_FEATURES 此处显示有关此函数的摘要
%   此处显示详细说明

for i = 1:n
    if (i==1)
        l = n;
        r = 2;
    elseif (i==n)
        l = n-1;
        r = 1;
    else
        l = i-1;
        r = i+1;
    end
    if ( hist(i) > hist(l) && hist(i) > hist(r) && hist(i) >= mag_thr )
        interp_hist_peak = 0.5*(hist(l)-hist(r))/(hist(l)-2*hist(i)+hist(r));
        bin = i + interp_hist_peak;
        if ( bin < 1 )
            bin = bin + n;
        elseif ( bin > n)
            bin = bin - n;
        end
        accu_intvl = ddata.intvl + ddata.x_hat(3);
        features(feat_index).ddata_index = ddata_index;
        % first octave is double size
        features(feat_index).x = (ddata.x + ddata.x_hat(1))*2^(ddata.octv-2);
        features(feat_index).y = (ddata.y + ddata.x_hat(2))*2^(ddata.octv-2);
        features(feat_index).scl = init_sigma * power(2,ddata.octv-2 + (accu_intvl-1)/intvls);        
        features(feat_index).ori = 2*pi*(bin-1)/n - pi;
        feat_index = feat_index + 1;
    end
end
end

