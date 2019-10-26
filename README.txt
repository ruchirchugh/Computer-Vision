Ruchir Chugh

Problem statement- http://vlm1.uta.edu/~athitsos/courses/cse4310_spring2019/assignments


TASK 2 -
In Task 2 using connected components I am finding the area of the person, depending on threshold value I have given a specific amount of area above which it ensures that person is present.
The task is working in all the given range plus some of the boundary conditions as well.

TASK 3 -
In Task 3 I am calling another function find_center which is same as find_bounding_box, it does not prints the image and the box. Using the row and column values I was able to calculate the center value.
In this there are three cases if both the files are same the it will show the output accordingly. If first file is larger than second then it will be handled accordingly.
Also after finding the difference in center positions I am dividing it by the difference of the frames to get the exact value.
The task is working in all the given conditions and is inaccurate in the situation when person is not present.
To check the output I have compared the movement of the centeroid which tells what will be the values of row and columns. For eg: if centeroid is moving downwards the value of rows will be positive along the y-axis.
