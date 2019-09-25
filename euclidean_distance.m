function distance = euclidean_distance(image1, image2)
    vector_img1 = image1(:);
    n = length(vector_img1);
    vector_img2 = image2(:);
    m = length(vector_img2);
    for i=1:n
        if(n == m)
            distance = sqrt(sum((vector_img1 - vector_img2) .^ 2));   
        end
    end
end