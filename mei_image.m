function result = mei_image(filename, start_frame, end_frame)
frames = read_video_frames(filename);
previous = frames(:,:,:,start_frame);
rows = size(previous, 1);
cols = size(previous, 2);
result = double(zeros(rows, cols));
for frame = (start_frame+1):end_frame
    current = frames(:,:,:,frame);
    diff = double(abs(current-previous));
    result = result + diff;
    previous = current;
end
