function result = shape_context_feature(edge_image, row, col, r1)
r = [r1, r1*2, r1*4, r1*8, r1*16];
result = zeros(5,12);
for rows = 1:5
    curr_row = r(rows);
    block = edge_image((row - curr_row):(row + curr_row),(col - curr_row):(col + curr_row));
    [r1,c1] = size(block);
    rc = ceil(r1/2);
    cc = ceil(c1/2);
    for i=rc-curr_row:rc+curr_row
        for j=cc-curr_row:cc+curr_row
            if block(i,j) == 1
                x=[i,j];y=[rc,cc];
                distance=norm(x-y);
                if (distance <= curr_row)
                    angle = atan2d(i-rc,j-cc);
                    angle = wrapTo360(angle);
                    for k=30:30:360
                        n = k/30;
                        if(angle<k && angle>=k-30)
                            result(rows,n) = result(rows,n)+1;
                        end
                    end
                end
            end
        end
    end 
end
for i =5:-1:2
        result(i,:) = result(i,:) - result(i-1,:);
end