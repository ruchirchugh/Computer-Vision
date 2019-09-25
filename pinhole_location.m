function result = pinhole_location(correspondences)
[rows,~] = size(correspondences);
c1 = perspective_calibration(correspondences);
midpoint_matrix =[];
for i= 1:rows
    for j= i+1:rows
        x1 = correspondences(i,1);
        y1 = correspondences(i,2);
        z1 = correspondences(i,3);
        u1 = correspondences(i,4);
        v1 = correspondences(i,5);
        x3 = correspondences(j,1);
        y3 = correspondences(j,2);
        z3 = correspondences(j,3);
        u2 = correspondences(j,4);
        v2 = correspondences(j,5);                
        x2 = 0;
        A2_Matrix = [[(c1(1,2)-c1(3,2)*u1),(c1(1,3)-c1(3,3)*u1)];[(c1(2,2)-c1(3,2)*v1),(c1(2,3)-c1(3,3)*v1)]];
        B2_Matrix = [((c1(3,1)*x2*u1) + u1 - (c1(1,1)*x2) - c1(1,4));((c1(3,1)*x2*v1) + v1 - (c1(2,1)*x2) - c1(2,4))];
        W2 = A2_Matrix\B2_Matrix;
        y2 = W2(1,1); z2 = W2(2,1);
        x4 = 0;
        A4_Matrix = [[(c1(1,2)-c1(3,2)*u2),(c1(1,3)-c1(3,3)*u2)];[(c1(2,2)-c1(3,2)*v2),(c1(2,3)-c1(3,3)*v2)]];
        B4_Matrix = [((c1(3,1)*x4*u2) + u2 - (c1(1,1)*x4) - c1(1,4));((c1(3,1)*x4*v2) + v2 - (c1(2,1)*x4) - c1(2,4))];
        W4 = A4_Matrix\B4_Matrix;
        y4 = W4(1,1); z4 = W4(2,1);
        p1 =[x1,y1,z1]';
        u1_new = [x2-x1,y2-y1,z2-z1]';
        p2 =[x3,y3,z3]';
        u2_new = [x4-x3,y4-y3,z4-z3]';
        A = [[dot(u1_new',u1_new),-(dot(u2_new',u1_new))];[dot(u1_new',u2_new),-(dot(u2_new',u2_new))]];
        B = [(dot(p2',u1_new))-(dot(p1',u1_new));(dot(p2',u2_new))-(dot(p1',u2_new))];
        W = A\B;
        a1 = W(1,1);
        a2 = W(2,1);
        midpoint = ((p1+a1*u1_new)+(p2+a2*u2_new))/2;
        midpoints = [midpoint(1),midpoint(2),midpoint(3)];
        midpoint_matrix = [midpoint_matrix; midpoints];
    end
end
result = mean(midpoint_matrix);