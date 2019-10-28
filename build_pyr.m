function [gauss_pyr, dog_pyr] = build_pyr(img, octvs, intvls, init_sigma)
%build the gauss and DOG pyramid
%   img: input image, octvs: , intvls: , init_sigma:

k = 2^(1/intvls);
sigma = ones(1,intvls+3);
sigma(1) = init_sigma;
sigma(2) = init_sigma*sqrt(k*k-1);
for i = 3:intvls+3
    sigma(i) = sigma(i-1)*k;
end

[img_height,img_width] =  size(img);
gauss_pyr = cell(octvs,1);
dog_pyr = cell(octvs,1);

octvs_size = [img_height,img_width];

% build gaussian pyramid
for i = 1:octvs
    if (i~=1)
        octvs_size = [round(octvs_size(1)/2),round(octvs_size(2)/2)];
    end
    gauss_pyr{i} = zeros(octvs_size(1),octvs_size(2),intvls+3);
    dog_pyr{i} = zeros(octvs_size(1),octvs_size(2),intvls+2);
end
for i = 1:octvs
    for j = 1:intvls+3
        if (i==1 && j==1)
            gauss_pyr{i}(:,:,j) = img;
        % downsample for the first image in an octave, from the s+1 image in previous octave.
        elseif (j==1)
            gauss_pyr{i}(:,:,j) = imresize(gauss_pyr{i-1}(:,:,intvls+1),0.5);
        else
            gauss_pyr{i}(:,:,j) = gaussian(gauss_pyr{i}(:,:,j-1),sigma(j));
        end
    end
end

% build DOG pyramid
for i = 1:octvs
    for j = 1:intvls+2
        dog_pyr{i}(:,:,j) = gauss_pyr{i}(:,:,j+1) - gauss_pyr{i}(:,:,j);
    end
end

for i = 1:size(dog_pyr,1)
    for j = 1:size(dog_pyr{i},3)
        imwrite(imbinarize(im2uint8(dog_pyr{i}(:,:,j)),0),['./dog_pyr/dog_pyr_',num2str(i),num2str(j),'.png']);
    end
end

end

