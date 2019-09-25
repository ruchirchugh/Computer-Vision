function [eigenvectors, eigenvalues] = mnist_pca(data_file, class_label, d)
vectors =[];
if data_file == "scrambled_mnist10000.bin"
    load_mnist
elseif data_file == "scrambled_mnist60000.bin"
    load_mnist1
end
[count,~]=size(mnist_labels);
for i=1 :count
    label = mnist_labels(i);  
    if class_label == label
        img = mnist_digits(:,:,i);
        current_image = reshape(img, [] , 1);
        vectors = [vectors current_image];
    end
end
number = size(vectors, 2);
%Normalizing Data
for i = 1:number
    image = double(vectors(:,i));
    image = (image - mean(image))/std(image);
    vectors(:,i) = image;
end
average = [mean(vectors')]';
centered_points = zeros(size(vectors));
for i = 1:number
    centered_points(:, i) = double(vectors(:, i)) - average;
end

covariance_matrix = centered_points * centered_points';
[eigenvectors, eigenvalues] = eig( covariance_matrix);

eigenvalues = diag(eigenvalues);
[eigenvalues, k] = sort(eigenvalues, 'descend');
eigenvectors = eigenvectors(:, k);

eigenvectors = eigenvectors(:,1:d);
eigenvalues = eigenvalues(1:d,:);