function [keypoints] = get_keypoints(dog_pyr, octvs, intvls, contr_thr, curv_thr, init_sigma)
% find the currect keypoints and remove the unstable keypoints
%   此处显示详细说明

sift_img_border = 5;
max_interp_steps = 5; % the maximum interpolation step
prelim_contr_thr = 0.5*contr_thr/intvls;

keypoints = struct('x',0,'y',0,'octv',0,'intvl',0,'x_hat',[0,0,0],'scl_octv',0);
keypoints_index = 1;

for i = 1:octvs
    [height, width] = size(dog_pyr{i}(:,:,1));
    dog_img_list = dog_pyr{i};
    % find extrema in middle intvls
    for j = 2:intvls+1
        dog_img = dog_img_list(:,:,j);
        for x = sift_img_border+1:height-sift_img_border
            for y = sift_img_border+1:width-sift_img_border
                % preliminary check on contrast
                if(abs(dog_img(x,y)) > prelim_contr_thr)
                    % check 26 neighboring pixels
                    if(isExtremum(dog_img_list,j,x,y))
                        ddata = interp_extremum(dog_img_list,height,width,i,j,x,y,sift_img_border,contr_thr,max_interp_steps, intvls, init_sigma);
                        if(~isempty(ddata))
                            if(~is_too_edge_like(dog_img,ddata.x,ddata.y,curv_thr))
                                 keypoints(keypoints_index) = ddata;
                                 keypoints_index = keypoints_index + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end

end

