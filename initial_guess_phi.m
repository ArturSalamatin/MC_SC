function phi = initial_guess_phi(x, data)
%% mu-guess
phi = zeros(size(x));
[phi(:,1), phi(:,2)] = MU(x, data);
end

