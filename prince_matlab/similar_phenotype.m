function Q = similar_phenotype(p_id, phenotype_network, size_d)

p_n = phenotype_network;
Q = zeros(1, 5);
for i = 1:size_d
    if p_n(i,1) == p_id
        Q(1) = i;
        p_n(i, i+1) = 0;
        for j = 2:5
            [B, I] = max(p_n(i,2:size_d+1));
            Q(j) = I;
            p_n(i, I+1) = 0;
        end
    end
end

Q = sort(Q);

end