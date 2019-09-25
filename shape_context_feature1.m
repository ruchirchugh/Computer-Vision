function result = shape_context_feature1(edge_image, row, col, r1)
radius_list = [r1, r1*2, r1*4, r1*8, r1*16];
result = zeros(5,12);
for bin_val = 1:5
    h = radius_list(bin_val);
    window = edge_image((row - h):(row + h),(col - h):(col + h));
    imshow(window);
    [r1,c1] = size(window);
    cx = ceil(r1/2);
    cy = ceil(c1/2);
    count = 0;
    disp([cx-h,cx+h,cy-h,cy+h]);
    for i=cx-h:cx+h
        for j=cy-h:cy+h
            if window(i,j) == 1
                Pos=[i,cx;j,cy];
                dis=dist(Pos);
%                 disp([i,j]);
                if (dis<=h)
                    if (i>=cx && j>cy)
                        angle = atan2d(j,i);%format
                        angle = 90-angle;                        
                    elseif (i>=cx && j<cy)
                        angle = atan2d(j,i);
                        angle = 180-angle;
                    elseif (i<cx && j<=cy)
                        angle = atan2d(j,i);
                        angle = 270-angle;
                    elseif (i<cx && j>=cy)
                        angle = atan2d(j,i);
                        angle = 360-angle;
                    else
                        continue;
                    end
%                     angle = atan2d(j,i);
%                     disp(angle);
                    for k=30:30:360
                        n = k/30;                        
                        if(angle<k && angle>=k-30)
                            count = count+1;
                            if bin_val == 1
                                result(bin_val,n) = result(bin_val,n) +1;
                            elseif bin_val == 2
                                result(bin_val,n) = result(bin_val,n)+1;
                            elseif bin_val == 3
                                result(bin_val,n) = count - result(bin_val-2,n) - result(bin_val-1,n);
                            elseif bin_val == 4
                                result(bin_val,n) = count - result(bin_val-3,n) - result(bin_val-2,n) - result(bin_val-1,n);
                            elseif bin_val == 5
                                result(bin_val,n) = count - result(bin_val-4,n) - result(bin_val-3,n) - result(bin_val-2,n) - result(bin_val-1,n);
                            else
                                continue;
                            end
                        end
                    end
                end
            end
        end
    end
end