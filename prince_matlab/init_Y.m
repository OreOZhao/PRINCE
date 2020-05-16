function Y = init_Y(Q, g_p_network, size_p)


Y = zeros(size_p, 1);

for q = Q
    for j = 1:size_p
        if(g_p_network(j, q) == 1)
            Y(j) = Y(j) + 1;
        end
    end
end

Y = Y./sum(Y);

end