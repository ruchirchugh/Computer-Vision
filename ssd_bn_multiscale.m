function [scores, max_scales] = ssd_bn_multiscale(grayscale, template, scales) 
scores = ones(size(grayscale)) * -10;
max_scales = zeros(size(grayscale));

for scale = scales
    if scale >= 1
       resized = resize_template(grayscale, 1/scale);
      
        temp=ssd_bn_search(resized, template);
        temp = imresize(temp, size(grayscale), 'bilinear');
    else
        scaled = resize_template(template, scale);
        temp=ssd_search3(grayscale, scaled);
    end
    
    maxes = (temp > scores);
    max_scales(maxes) = scale;
    scores(maxes) = temp(maxes);
end
end