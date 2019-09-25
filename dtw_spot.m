function result = dtw_spot(input_video, class_thresholds)
training = 'gesture_videos/digits_model_quan_ex3.avi';
ground_truth = load('gesture_videos/start_end_frames_model_quan_ex3.txt');
n = size(read_video_frames(input_video),4);
test_col = n-2;
test_trajectory = green_hand_trajectory(input_video, 2, test_col+1);
result = [];
for k = 1:10
    gesture_class = ground_truth(k,1);
    start_point = ground_truth(k,2);
    end_point = ground_truth(k,3);
    train_trajectory = green_hand_trajectory(training,start_point,end_point);
    train_row = end_point - start_point + 1;
    scores = zeros(train_row,test_col);
    scores(1:train_row,1) = Inf;%first col to avoid selecting that value    
    for i = 2 : train_row
        for j = 2 : test_col
            minimum_value = min([scores(i-1, j), scores(i, j-1), scores(i-1, j-1)]);
            scores(i,j) = norm(train_trajectory(i,:) - test_trajectory(j,:) ) + minimum_value;
        end
    end      
    last_row = scores(train_row,:);
    end_val = scores(train_row,:)<class_thresholds(k);
    [~, end_val_col] = find(end_val);
    values = [last_row(end_val)',end_val_col'];
    for i = 1:length(values)
        num = values(i,1);
        row = train_row;
        col = values(i,2);
        while num > 0
            prev = [scores(row-1, col), scores(row, col-1), scores(row-1, col-1)];
            num = min(prev);
            [a,b] = find(prev == num);
            if b == 1
                row = row-1;
            elseif b == 2
                col = col-1;
            else
                row = row-1; col = col-1;
            end
        end
        start_frame = col; 
        end_frame = values(i,2);
        result = [result; [start_frame,end_frame,gesture_class]];
    end
end