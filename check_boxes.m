function [current_tp, current_fp, current_fn] = check_boxes(boxes, current_gt, iou_thr)
[detected_rows,~] = size(boxes);
[actual_rows, ~] = size(current_gt);
iou_cur = 0;
current_tp = 0;
current_fp = 0;
current_fn = 0;
iou_matrix = zeros(detected_rows,actual_rows);
if detected_rows == 0
        current_fn = actual_rows;
else
    for i = 1:detected_rows
        for j = 1:actual_rows
                topA = current_gt(j,1);
                bottomA = current_gt(j,2);
                leftA = current_gt(j,3);
                rightA = current_gt(j,4);           
                topB = boxes(i,1);
                bottomB = boxes(i,2);
                leftB = boxes(i,3);
                rightB = boxes(i,4);
                top_A_in_B = max(topA, topB);
                bottom_A_in_B = min(bottomA, bottomB);
                left_A_in_B = max(leftA, leftB);
                right_A_in_B = min(rightA, rightB);           
                heightA = bottomA - topA + 1;
                widthA = rightA - leftA + 1;
                heightB = bottomB - topB + 1;
                widthB = rightB - leftB + 1;
                height_A_in_B = bottom_A_in_B - top_A_in_B + 1;
                width_A_in_B = right_A_in_B - left_A_in_B + 1;            
                Area_A = heightA * widthA;
                Area_B = heightB * widthB;
                Area_A_in_B = height_A_in_B * width_A_in_B;
    %                     boxa=[topA,leftA,widthA,heightA];
    %                     boxb=[topB,leftB,widthB,heightB];
    %                     overlapRatio = bboxOverlapRatio(boxa,boxb);
    %                     disp(j);
    %                     disp(sprintf('ratio: %d\n', overlapRatio));
                   if Area_A_in_B <= 0
                       iou_cur = 0;
    %                     disp(iou_cur);
                   else
                       Area_A_un_B = (Area_A + Area_B) - Area_A_in_B;               
                       iou_cur = Area_A_in_B / Area_A_un_B;
    %                    disp(sprintf('intersection: %d', Area_A_in_B));
    %                    disp(sprintf('union: %d', Area_A_un_B));
    %                    disp(iou_cur);  
    %                    iou_matrix(detected_rows,actual_rows)=iou_cur;
                       if iou_cur>=iou_thr
                           current_tp = current_tp+1;
                       else
                           iou_matrix(i,j) = iou_cur;
                           current_fp = current_fp+1; 
%                          current_fn = actual_rows - current_tp;
                       end
                   end
        end
    end
current_fn = actual_rows - current_tp;

end