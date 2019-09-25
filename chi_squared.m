function result = chi_squared(sc1, sc2)
[r,c] = size(sc1);
distance = zeros(r,c);
for x=1:r
    for y=1:c
        distance(x,y) = ((sc1(x,y)-sc2(x,y))^2) / (sc1(x,y)+sc2(x,y));
    end
end
result = (sum(sum(distance)))/2;