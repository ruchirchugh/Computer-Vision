function result = person_speed(filename1,filename2)

[~, frame1] = parse_frame_name(filename1);
[~, frame2] = parse_frame_name(filename2);
if (frame1==frame2)
    rows_per_frame =0; cols_per_frame = 0;
    disp("SAME IMAGE ");
elseif (frame1<frame2)
    [top1, bottom1, left1, right1] = find_center(filename1);
    [top2, bottom2, left2, right2] = find_center(filename2);
    center_row1 = (top1+bottom1)/2; center_column1 = (left1+right1)/2;
    center_row2 = (top2+bottom2)/2; center_column2 = (left2+right2)/2;
    diff = frame2-frame1+1;
    rows_per_frame = (center_row2-center_row1)/diff;
    cols_per_frame = (center_column2-center_column1)/diff;
else
    [top1, bottom1, left1, right1] = find_center(filename1);
    [top2, bottom2, left2, right2] = find_center(filename2);
    center_row1 = (top1+bottom1)/2; center_column1 = (left1+right1)/2;
    center_row2 = (top2+bottom2)/2; center_column2 = (left2+right2)/2;
    diff = frame1-frame2+1;
    rows_per_frame = (center_row1-center_row2)/diff;
    cols_per_frame = (center_column1-center_column2)/diff;
end
result =[rows_per_frame, cols_per_frame];
disp("Velocity = ["+rows_per_frame+","+cols_per_frame+"]");