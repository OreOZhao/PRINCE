function [S] = normalize_ppi(ppi, size_p)

sum_col = sum(ppi);
sum_row = sum(ppi, 2);

sqrt_col = sqrt(sum_col);
sqrt_row = sqrt(sum_row);

S = ppi;

for i = 1:size_p
    for j = 1:size_p
        S(i, j) = S(i, j) / sqrt_col(1, j) / sqrt_row(i, 1);
        %S(i, j) = S(i, j) / sum_col(j);
    end
end

end