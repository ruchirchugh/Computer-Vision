Ruchir Chugh

Problem statement- http://vlm1.uta.edu/~athitsos/courses/cse4310_spring2019/assignments

TASK1 - To send a file in a binary image either first store the matrix of an image in another variable and then send it to remove_holes-

>> a = imread("zebra_with_holes.gif");
>> result = remove_holes(a);

Or sent the file like this - 

>> result = remove_holes(imread("zebra_with_holes.gif"));
 
