function [accuracy, confusion_matrix] = nnc_euclidean_stats()
count = 0;
confusion_matrix = zeros(10,10);
    for x=1:10
        for y=1:10
            i = x-1;
            test_image = imread("digits_test/label"+ string(i) +"_test"+ string(y) +".png");
            predicted_label = nnc_euclidean(test_image);
            if i==0
                if predicted_label==0
                    count = count+1;
                    confusion_matrix(10,10) = confusion_matrix(10,10) + 1;  
                else
                    confusion_matrix(10,predicted_label) = confusion_matrix(10,predicted_label) + 1;
                end
            elseif predicted_label == i
                count = count+1;
                confusion_matrix(i,predicted_label) = confusion_matrix(i,predicted_label) + 1;
            elseif predicted_label==0                
                confusion_matrix(i,10) = confusion_matrix(i,10) + 1;                
            else
                confusion_matrix(i,predicted_label) = confusion_matrix(i,predicted_label) + 1;
            end
        end
    end
accuracy = count/100;
confusion_matrix = confusion_matrix/10;
end