function result = ssd_bn_search(grayscale, template)
[x,y]=size(grayscale);
result = ones(size(grayscale)) * -1;
template = template - mean(template(:));
[R,C]=size(template);
row_cen=C/2 ;col_cen=R/2;
for i=1:x
    for j=1:y
        if (i-col_cen<1 || j-row_cen<1) 
            continue
        else
            if (i+col_cen<x && j+row_cen<y)
                window=grayscale((i-col_cen):(i+col_cen-1), (j-row_cen):(j+row_cen-1));
                window = window - mean(window(:));
                window_vector=window(:);
                template_vector=template(:);
                diff_vector = window_vector - template_vector;
                squared_diffs = diff_vector .* diff_vector;
                ssd_score = sum(squared_diffs);
                result(i,j) = ssd_score;
            end
        end
    end
end
% imshow(result);