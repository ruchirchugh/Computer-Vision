function class_label = pca_classifier(image, data_file, d)

if data_file == "scrambled_mnist10000.bin"
    load_mnist
elseif data_file == "scrambled_mnist60000.bin"
    load_mnist1
end
    total = size(mnist_labels,1);
    backprop = [];
    for j=1:10
        current_label = j-1;
        vectors = [];
        for i=1:total
            actual_label = mnist_labels(i);
            if actual_label == current_label
                image1 = mnist_digits(:,:,i);
                vector1 = reshape(image1, [], 1);
                vectors = [vectors vector1];
            end
        end       
        number = size(vectors,2);    
        for index = 1:number
            mnist_img = double(vectors(:,index));
            mnist_img = (mnist_img - mean(mnist_img))/std(mnist_img);
            vectors(:,index) = mnist_img;
        end        
        avg = mean(vectors.').';
        cen_points = zeros(size(vectors));
        num = size(vectors,2);
        for index = 1:num
            cen_points(:,index) = double(vectors(:,index)) - avg;
        end
        covariance_matrix = cen_points * cen_points.';
        [eigen_vectors, eigen_values] = eig(covariance_matrix);
        eigen_values = diag(eigen_values);
        [eigen_values, k] = sort(eigen_values, 'descend');
        eigen_vectors = eigen_vectors(:, k);
        %eigenvalues = eigen_values(1:d,:);
        eigenvectors = eigen_vectors(:,1:d);
        proj = eigenvectors.'*cen_points;        
        e_proj = eigenvectors * proj;
        back_projection = e_proj + avg;       
        img_vec = reshape(image, [], 1);       
        img_vec = double(img_vec);
        img_norm = (img_vec - mean(img_vec))/std(img_vec);        
        diff = (back_projection - double(img_norm));
        sq_diff = diff.^2;
        sum_sq_diff = sum(sq_diff,1);
        error = mean(sum_sq_diff);       
        backprop = [backprop;[error, current_label]];
    end 
    arranged = sortrows(backprop,'ascend');
    class_label = arranged(1,2);