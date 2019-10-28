function [hist] = descr_hist(gauss_img, ddata_x, ddata_y, feat_ori, scl_octv, d, n, descr_length)
%DESCR_HIST 此处显示有关此函数的摘要
%   此处显示详细说明

% determines the size of a single descriptor orientation histogram
sift_descr_scl_fctr = 3.0;

hist_width = sift_descr_scl_fctr * scl_octv;
radius = round( hist_width * (d + 1) * sqrt(2) / 2 );
hist = zeros(1,descr_length);
for i = -radius:radius
    for j = -radius:radius
        j_rot = j*cos(feat_ori) - i*sin(feat_ori);
        i_rot = j*sin(feat_ori) + i*cos(feat_ori);
        r_bin = i_rot/hist_width + d/2 - 0.5;
        c_bin = j_rot/hist_width + d/2 - 0.5;
        if (r_bin > -1 && r_bin < d && c_bin > -1 && c_bin < d)
            [mag, ori, flag] = calc_grad_mag_ori(gauss_img,ddata_x+i,ddata_y+j);
            if (flag == 1)
                ori = ori - feat_ori;
                while (ori < 0)
                    ori = ori + 2*pi;
                end
                while (ori >= 2*pi)
                    ori = ori - 2*pi;
                end
                o_bin = ori * n / (2*pi);
                w = exp( -(j_rot*j_rot+i_rot*i_rot) / (2*(0.5*d*hist_width)^2) );
                hist = interp_hist_entry(hist,r_bin,c_bin,o_bin,mag*w,d,n);
            end
        end
    end
end

end

