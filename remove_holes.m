function result = remove_holes(image)%binary = imread(image);
reverse = imcomplement(image);
[labels, number] = bwlabel(reverse, 4);
[rows,cols]=size(reverse);
for i=1:rows
    for j=1:cols
        if reverse(1,1) == 0
           reverse(i,j) = 0;
           continue;
        elseif labels(i,j)==1
           reverse(i,j) = 255;
        else
           reverse(i,j) = 0;
        end
    end
end
result=imcomplement(reverse);
figure(1);imshow(result);
%%
%TASK1 - To send a file in a binary image either first store the matrix of an image in another variable and then send it to remove_holes-

%>> a = imread("zebra_with_holes.gif");
%>> result = remove_holes(a);

%Or sent the file like this - 
%>> result = remove_holes(imread("zebra_with_holes.gif"));