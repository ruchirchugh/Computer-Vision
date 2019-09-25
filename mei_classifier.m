function class_label = mei_classifier(filename, start_frame, end_frame)
training_file = "gesture_videos/digits_model_quan_ex3.avi";
predicted_mei = mei_image(filename, start_frame, end_frame);
predicted_mei = predicted_mei(:,:,3);
labels = 10;
distances = [];

result_0 = mei_image(training_file, 22, 91);
dist0 = euclidean_distance(predicted_mei,result_0(:,:,3));
distances = [distances,dist0 ];

result_1 = mei_image(training_file, 143, 165);
dist1 = euclidean_distance(predicted_mei,result_1(:,:,3));
distances = [distances,dist1 ];

result_2 = mei_image(training_file, 220, 300);
dist2 = euclidean_distance(predicted_mei,result_2(:,:,3));
distances = [distances,dist2 ];

result_3 = mei_image(training_file, 350, 445);
dist3 = euclidean_distance(predicted_mei,result_3(:,:,3));
distances = [distances,dist3 ];

result_4 = mei_image(training_file, 495, 544);
dist4 = euclidean_distance(predicted_mei,result_4(:,:,3));
distances = [distances,dist4 ];

result_5 = mei_image(training_file, 608, 701);
dist5 = euclidean_distance(predicted_mei,result_5(:,:,3));
distances = [distances, dist5];

result_6 = mei_image(training_file, 763, 850);
dist6 = euclidean_distance(predicted_mei,result_6(:,:,3));
distances = [distances, dist6];

result_7 = mei_image(training_file, 906, 961);
dist7 = euclidean_distance(predicted_mei,result_7(:,:,3));
distances = [distances, dist7];

result_8 = mei_image(training_file, 1035, 1150);
dist8 = euclidean_distance(predicted_mei,result_8(:,:,3));
distances = [distances, dist8];

result_9 = mei_image(training_file, 1206, 1277);
dist9 = euclidean_distance(predicted_mei,result_9(:,:,3));
distances = [distances, dist9];

[asec, c] = sort(distances);
    for i = 1:labels
        dist = distances(i);
        if dist == asec(1)
            class_label = labels-1;
        end
    end