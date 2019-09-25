function [tp, fp, fn] = dtw_spot_accuracy(ground_truth, gestures, iou_threshold)
tp = 0; fp = 0; fn = 0;
ground_truth = load(ground_truth);
for i=1:10
    ious = [];
    for j = 1:length(gestures)       
        test_start = ground_truth(i,2);
        test_end = ground_truth(i,3);
        training_start = gestures(j,1);
        training_end = gestures(j,2);      
        area_of_intersection = max(test_start,training_start) - min(test_end,training_end);
        union = min(test_start,training_start) - max(test_end,training_end);
        IoU_score = area_of_intersection/union;
        if IoU_score > 0
            ious = [ious ; IoU_score];
            if IoU_score >= iou_threshold
                tp = tp + 1;
            else
                fp = fp + 1;
            end
        end        
    end    
    if max(ious) < iou_threshold
       fn = fn + 1;    
    end
end