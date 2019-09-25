function result = orientation_difference(o,Q)
diff = abs(o-Q);
while diff>=180
    diff = diff-180;
end
if(diff>90)
    deg = 180 - diff;
    result = deg;
else
    result = diff;
end