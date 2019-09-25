function class_label = dtw_classifier_green(filename, start_frame, end_frame)
training = 'gesture_videos/digits_model_quan_ex3.avi';
ground_truth = load('gesture_videos/start_end_frames_model_quan_ex3.txt');
test_col = end_frame - start_frame + 1;
test_trajectory = green_hand_trajectory(filename, start_frame, end_frame);
first_point_test = test_trajectory(1,:);
distances = zeros(10,1);
for k = 1:length(ground_truth)
    start_point = ground_truth(k,2);
    end_point = ground_truth(k,3);
    train_row = end_point - start_point + 1;
    scores = zeros(train_row,test_col);
    train_trajectory = green_hand_trajectory(training,start_point,end_point);
    first_point_train = train_trajectory(1,:);
    scores(1,1) = norm(first_point_test - first_point_train);
    for i = 2 : train_row
        scores(i, 1) = scores(i-1, 1) + norm(train_trajectory(i,:) - first_point_test);
    end
    for j = 2 : test_col
        scores(1, j) = scores(1, j-1) + norm(first_point_train - test_trajectory(j,:));
    end    
    for i = 2 : train_row
        for j = 2 : test_col
            minimum_value = min([scores(i-1, j), scores(i, j-1), scores(i-1, j-1)]);
            scores(i,j) = norm(test_trajectory(j,:)-train_trajectory(i,:)) + minimum_value;
        end
    end 
    %[r,c]=size(scores(end));  
    distances(k) = scores(i,j); 
end
%disp(distances);
d = min(distances);
class_label = find(d == distances)-1;