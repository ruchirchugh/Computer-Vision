function result = ocean_segmentation(image)
%filename = 'ocean2.jpg';
gray = read_gray(image);
dy = [-1 -2 -1 ; 0  0  0 ; 1  2  1;];
dy = dy / (sum(abs(dy(:))));
dygray = abs(filter2(dy, gray));
[labels, number] = bwlabel(dygray, 4);
[rows,cols]=size(dygray);
for i=1:rows
    for j=1:cols
        if dygray(i,j) >5
           dygray(i,j) = 255;
        else
           dygray(i,j) = 0;
        end
    end
end
sky_with_holes = ~(gray > 180);
dilated_sky = imdilate(sky_with_holes, ones(4,4));
sky = remove_holes(dilated_sky);
img = imfill(dygray,'holes');
waste = imdilate(img, ones(3,3));
grass = get_component(waste, 1);
grass = remove_holes(grass);
mountain = get_component(waste, 2);
mountain = remove_holes(mountain);
part1 = get_component(waste, 4);
part2 = get_component(waste, 5);
part3 = get_component(waste, 6);
ocean = mountain + grass - sky + part1 + part2 + part3;
figure(3);imshow(~mountain & ocean);title('Water');
figure(2);imshow(sky);title('Sky');
figure(1);imshow(image);title('Image');