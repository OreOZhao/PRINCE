function [idx, genes, values] = top10genes(F, gene_name)

tmp = F;
genes = cell(1, 10);
idx = zeros(1, 10);
values = zeros(1, 10);
for i = 1:10
    [values(i), idx(i)] = max(tmp);
    tmp(idx(i)) = 0;
    genes(i) = gene_name(idx(i));
end