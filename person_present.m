function result = person_present(filename)

givenframegray = read_gray(filename);
[sequence_name, frame] = parse_frame_name(filename);
previousframe = make_frame_name(sequence_name, frame-1);
previousframegray = read_gray(previousframe);
[sequence_name, frame] = parse_frame_name(filename);
nextframe = make_frame_name(sequence_name, frame+1);
nextframegray = read_gray(nextframe);
diff1 = abs(givenframegray - previousframegray);
diff2 = abs(givenframegray - nextframegray);
motion = min(diff1, diff2);
threshold = 3; 
thresholded = (motion > threshold); 
[labels, number] = bwlabel(thresholded, 4);
counters = zeros(1,number);
for i = 1:number
    component_image = (labels == i);
    counters(i) = sum(component_image(:));
end
[area, id] = max(counters);    
person = (labels == id);
%figure(3);imshow(person, []);disp(area);
if (area >1950)
    present=1;
    %disp("Person is Present!");
else
    present=0;
end
disp("Result = "+present);
result = present;