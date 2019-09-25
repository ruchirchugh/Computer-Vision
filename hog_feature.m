function result = hog_feature(image, top, left, block_size)
bot = top + block_size;
right = left + block_size;
window = image(top:bot-1 , left:right-1);
dx = [-1,0,1];
dy = [-1,0,1]';
[r,c] = size(window);
cen = ceil(r/2);
disp([top,left,bot,right,r,c,cen]);
block_1= window(1:cen,1:cen);
block_2= window(1:cen,cen+1:block_size);
block_3= window(cen+1:block_size,1:cen);
block_4= window(cen+1:block_size,cen+1:block_size);
values = [];
nbins = [20,40,60,80,100,120,140,160,180];
for i=1:4
    if i==1
        gradient_x = imfilter(block_1, dx, 'same', 'symmetric');
        gradient_y = imfilter(block_1, dy, 'same', 'symmetric');
        angles = abs(atan2d(gradient_y,gradient_x));
        [val,~] = histcounts(angles,9);
        values(i,:) = val;
    elseif i==2
        gradient_x = imfilter(block_2, dx, 'same', 'symmetric');
        gradient_y = imfilter(block_2, dy, 'same', 'symmetric');
        angles = abs(atan2d(gradient_y,gradient_x));
        [val,~] = histcounts(angles,9);
        values(i,:) = val;
    elseif i==3
        gradient_x = imfilter(block_3, dx, 'same', 'symmetric');
        gradient_y = imfilter(block_3, dy, 'same', 'symmetric');
        angles = abs(atan2d(gradient_y,gradient_x));
        [val,~] = histcounts(angles,9);
        values(i,:) = val;
    elseif i==4
        gradient_x = imfilter(block_4, dx, 'same', 'symmetric');
        gradient_y = imfilter(block_4, dy, 'same', 'symmetric');
        angles = abs(atan2d(gradient_y,gradient_x));
        [val,~] = histcounts(angles,9);
        values(i,:) = val;
    end
end
v = values(:);
v = v / norm(v);
v(v > 0.2) = 0.2;
result = v / norm(v);