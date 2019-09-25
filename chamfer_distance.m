function distance = chamfer_distance(image1, image2)
    v1_binary = (image1 ~= 0);
    v2_binary = (image2 ~= 0);
    n1 = sum(sum(v1_binary));
    m1 = sum(sum(v2_binary));
    dt1 = bwdist(image1);
    dt2 = bwdist(image2);
    chamfer_v1_to_v2 = sum(sum(v1_binary .* dt2)) / n1;
    chamfer_v2_to_v1 = sum(sum(v2_binary .* dt1)) / m1;
    distance = chamfer_v1_to_v2 + chamfer_v2_to_v1;
end