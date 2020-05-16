function F = RWR(Y, S, alpha, iters)

F = Y;

for t = 1:iters
    F_n = alpha * S * F + (1 - alpha) * Y;
    F = F_n;
end


end