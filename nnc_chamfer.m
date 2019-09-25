function class_label = nnc_chamfer(test_image)
    temp = 100000;
    for x=0:9
        for y=1:15
            training_image = imread("digits_training/label"+ string(x) +"_training"+ string(y) +".png");
            distance = chamfer_distance(test_image, training_image);
            if distance < temp
                temp = distance;
                class_label = x;
            end
        end
    end
end