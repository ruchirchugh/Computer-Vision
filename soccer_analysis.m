function result = soccer_analysis(image)
color = double(imread(image));
r = color(:,:, 1);
g = color(:,:, 2);
b = color(:,:, 3);
green = ((g - r > 00) & (g - b > 00));
g_comp = get_component(green, 1);
field = remove_holes(g_comp);
red = ((r - g > 100) & (r - b > 90));
blue =((b - g > 35) & (b - r > 35));
[~,cols]=size(field);
for i=1:195
    for j=1:cols
        red(i,j)=0;
        blue(i,j)=0;
    end
end
figure(3);imshow(blue);title('Blue Players');
figure(2); imshow(red);title('Red Players');
figure(1);imshow(field);title('Field');
%subplot(2,2,1),imshow(field);title('Field');
%subplot(2,2,2),imshow(red);title('Red Players');
%subplot(2,2,3),imshow(blue);title('Blue Players');