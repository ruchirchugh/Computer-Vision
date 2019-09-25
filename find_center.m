function [top, bottom, left, right] = find_center(filename) 
image = imread(filename,'tif');
if(filename ~= "walkstraight/frame0000.tif")
    frame1 = read_gray(filename);
    [sequence_name, frame] = parse_frame_name(filename);
    frame2 = make_frame_name(sequence_name, frame-1);
    frame2gray = read_gray(frame2);
    frame3 = make_frame_name(sequence_name, frame+1);
    frame3gray = read_gray(frame3);
    diff1 = abs(frame1 - frame2gray);
    diff2 = abs(frame1 - frame3gray);
    motion = min(diff1, diff2);
    threshold = 3;
    thresholded = (motion > threshold);
    [labels, number] = bwlabel(thresholded, 4);
    counters = zeros(1,number);
    for i = 1:number
    component_image = (labels == i);
    counters(i) = sum(component_image(:));
    end
    [~, id] = max(counters);    
    person = (labels == id);
    [rows, cols] = size(person);
    [row_coords, col_coords] = find(person);
    col_arr = {};
    rows_arr = {};
    for j = 1:cols
        for i = 1:rows
            if person(i,j) == 1
                col_arr = [col_arr [i j]];
            end
        end
    end
    allcolumns = col_arr{1};
    [m,n] = size(col_arr);
    left_col = allcolumns(2);
    right_col = col_arr{n}(2);
    for i = 1:rows
        for j = 1:cols
            if person(i,j) == 1
                rows_arr = [rows_arr [i j]];
            end
        end
    end
    allrows = rows_arr{1};
    [m,n] = size(rows_arr);
    top_row = allrows(1);
    bottom_row = rows_arr{n}(1);
    left = left_col-5;
    right = min(right_col+5,320);
    bottom = bottom_row+5;
    top = top_row-5;
    rectangle=draw_rectangle(image, [255 255 0], top, bottom, left, right);
    result=[top, bottom, left, right];
else
    disp("Cannot check for first frame");
end