function [ddata] = interp_extremum(dog_img_list, height, width, octv, intvl, x, y, img_border, contr_thr, max_interp_steps, intvls, init_sigma)
%INTERP_EXTREMUM 此处显示有关此函数的摘要
%   此处显示详细说明

i = 1;
while (i <= max_interp_steps)
    df = deriv(dog_img_list,intvl,x,y);
    H = hessian(dog_img_list,intvl,x,y);
    [U,S,V] = svd(H);
    T=S;
    T(S~=0) = 1./S(S~=0);
    svd_inv_H = V * T' * U';
    x_hat = - svd_inv_H*df;
    if( abs(x_hat(1)) < 0.5 && abs(x_hat(2)) < 0.5 && abs(x_hat(3)) < 0.5)
        break;
    end
    x = x + round(x_hat(1));
    y = y + round(x_hat(2));
    intvl = intvl + round(x_hat(3));
    if (intvl < 2 || intvl > intvls+1 || x <= img_border || y <= img_border || x > height-img_border || y > width-img_border)
        ddata = [];
        return;
    end
    i = i+1;
end
if (i > max_interp_steps)
    ddata = [];
    return;
end
contr = dog_img_list(x,y,intvl) + 0.5*df'*x_hat;  %精确极值点的像素值
if ( abs(contr) < contr_thr/intvls )
    ddata = [];
    return;
end
ddata.x = x;
ddata.y = y;
ddata.octv = octv;
ddata.intvl = intvl;
ddata.x_hat = x_hat;
ddata.scl_octv = init_sigma * power(2,(intvl+x_hat(3)-1)/intvls);

end

