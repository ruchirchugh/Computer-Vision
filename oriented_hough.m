function votes = oriented_hough(grayscale, thetas, rhos, thr1, thr2)
%grayscale = read_gray('road2.bmp');
%thr1 = 2;
% thr2 = 30;
edge_pixels = canny(grayscale, thr1);
%[h thetas rhos] = hough(edge_pixels);
[~,r] = size(rhos);
[~,c] = size(thetas);
votes = zeros(r,c);
dx = [-1 0 1];
dy = [-1,0,1]';
gradient_x = imfilter(grayscale, dx, 'same', 'symmetric');
gradient_y = imfilter(grayscale, dy, 'same', 'symmetric');
all_thetas =  atan2d(gradient_y, gradient_x);
[row,col] = size(edge_pixels);
for j=1:row
    for i=1:col
        if edge_pixels(j,i) == 1
           o = all_thetas(j,i);
           for k=1:c
               if orientation_difference(o,thetas(1,k)) <= thr2
                   rho_val = (j * cos(thetas(1,k))) + (i * sin(thetas(1,k)));
                   [value,index] = sort(abs(rhos-rho_val));
                   %disp(size(value));
                    if value(1)==value(2)
                        votes(index(1),k) = votes(index(1),k) + 0.5;
                        votes(index(2),k) = votes(index(2),k) + 0.5;
                    else
                        votes(index(1),k) = votes(index(1),k) + 1;
                    end
               end
           end           
        end
    end
end
disp(votes);
% 
% result = grayscale * 0.7;
% for i = 1:1
%     max_value = max(max(votes));
%     [rho_indices, theta_indices] = find(votes == max_value);
%     rho_index = rho_indices(1);
%     theta_index = theta_indices(1);
%     distance = rhos(rho_index);
%     angle = thetas(theta_index);
%     result = draw_line2(result, distance, angle);
%     votes(rho_index, theta_index) = 0;
% end
% figure(2); imshow(result, []);