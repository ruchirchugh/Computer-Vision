function trajectory = green_hand_trajectory(filename, start_frame, end_frame)
n = end_frame - start_frame + 1;
trajectory = zeros(n,2);
video_frames = read_video_frames(filename);
index = 1;
for i= start_frame : end_frame
    [~,~,centers] = green_hands(video_frames, i, [40,30]);
    r = centers(1);
    c = centers(2);
    trajectory(index,1) = r;
    trajectory(index,2) = c;
    index = index+1;
end