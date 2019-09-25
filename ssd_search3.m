function result = ssd_search3(grayscale, template) 
[x, y] = size(grayscale);
[r, c] = size(template);
result= -1*(ones(x,y));  
template = template - mean(template(:));
temp_row_cen= r/2;
temp_col_cen= c/2;
row_end=x-temp_row_cen;
col_end=y-temp_col_cen;
for i=temp_row_cen:row_end
  for j=temp_col_cen:col_end
        window=grayscale(i-temp_row_cen+1:i+temp_row_cen,j-temp_col_cen+1:j+temp_col_cen);
        window = window - mean(window(:));
        window_vector = window(:) ;
        template_vector = template(:); 
        diff_vector = window_vector - template_vector;
        squared_diffs = diff_vector .* diff_vector;
        ssd_score = sum(squared_diffs);
        result(i,j) = ssd_score;
  end 
end 
imshow(result);
end