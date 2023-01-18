function [x,phi] = solute_distribution2(x, phi,...
    s1_idx, s2_idx, data, c1, c2)
% The function implements Newton approach to solve the
% nonlinear system of algebraic equations iteratively.
% The system to solve contains four equations for four
% unknows, (x1; x2; mu1; mu2)
global test_phiDistribId test_concDistribId
global componentsSpecs phaseEqId concDistrib
eps = 1E-8;
% chemical potential of core-component is zero
% where the core intersects with the transport zone of the other
% component
if(s1_idx > s2_idx)
    phi(s2_idx:s1_idx, 1) = 0;
else
    phi(s1_idx:s2_idx, 2) = 0;
end
% initial guess must be consistent with the phase diagram
x(:,1) = min(x(:,1), ...
    interp1(data.curve1.x2, data.curve1.x1, x(:,2)));
x(:,2) = min(x(:,2), ...
    interp1(data.curve2.x1, data.curve2.x2, x(:,1)));

n = max(s1_idx, s2_idx);
if(~isempty(test_concDistribId))
    figure(test_concDistribId)
    cla
    plot(x(:,1), ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(x(:,2), ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
end

i=1;
while(true)
    correction = 2*i/(3+2*i);
    %% save previous guess
    phi_prev = phi;
    x_prev = x;
    %% calculate corrections
    A = make_matrix(x(1:n, :), phi(1:n, :), s1_idx, s2_idx, data);
    b = make_rhs(x(1:n, :), phi(1:n, :), s1_idx, s2_idx, data, c1, c2);
    dx = (A\b)*correction;
    %% new guess
    x(1:n, 1) = x(1:n, 1) + dx(1:n);
    x(1:n, 2) = x(1:n, 2) + dx(n+[1:n]);
    phi(1:n, 1) = phi(1:n, 1) + dx(2*n+[1:n]);
    phi(1:n, 2) = phi(1:n, 2) + dx(3*n+[1:n]);
    
    if(~isempty(test_concDistribId))
        figure(test_concDistribId)
        cla
        plot(x(:,1), ...
            componentsSpecs.color1, 'LineWidth', componentsSpecs.lw, ...
            'LineStyle', '--')
        plot(x(:,2), ...
            componentsSpecs.color2, 'LineWidth', componentsSpecs.lw, ...
            'LineStyle', '--')
        
        figure(phaseEqId)
        plot(x(:,1), x(:,2), 'r--')
    end
    if(~isempty(test_phiDistribId))
        figure(test_phiDistribId)
        cla
        plot(phi(:,1), ...
            componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
        plot(phi(:,2), ...
            componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
    end
    
    
    
    %% check constraints
    x = max(0, x);
    %     x(:,1) = min(max(data.sat.x1, data.xSat1), x(:,1));
    %     x(:,2) = min(max(data.sat.x2, data.xSat2), x(:,2));
    
    x(:,1) = min(x(:,1), ...
        interp1(data.curve1.x2, data.curve1.x1, x(:,2)));
    x(:,2) = min(x(:,2), ...
        interp1(data.curve2.x1, data.curve2.x2, x(:,1)));
    
    phi = min(0, phi);
    % correct the mu-value in the core-transport zone
    if(s1_idx < s2_idx)
        phi(s2_idx:s1_idx, 1) = 0;
    else
        phi(s1_idx:s2_idx, 2) = 0;
    end
    
    if(~isempty(test_concDistribId))
        figure(test_concDistribId)
        plot(x(:,1), ...
            componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
        plot(x(:,2), ...
            componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
        
        figure(phaseEqId)
        plot(x(:,1), x(:,2), 'k-')
        
        i=i+1;
        [i-1, correction]
    end
    if(~isempty(test_phiDistribId))
        figure(test_phiDistribId)
        plot(phi(:,1), ...
            componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
        plot(phi(:,2), ...
            componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
    end
    
    %% check convergence
    d_conc = x-x_prev;
    d_phi = phi-phi_prev;
    if(     all(all(abs(x-x_prev)<=(x+x_prev)*eps)) && ...
            (all(all(abs(phi-phi_prev)<=abs(phi+phi_prev)*eps | ...
            abs(phi)<=1E-8))) ...
            )
        break;
    end
end
end

function A = make_matrix(x, phi, s1_idx, s2_idx, data)

n = max(s1_idx, s2_idx);
N = 4*n;

%% row ids
I = [1:n, 1:(n-1), 2:n, ... % block-1 row-1
    1:n, 1:(n-1), 2:n, ... % block-3 row-1
    n+[1:n, 1:n, 1:n], ... % block-1-2-3 row 2
    2*n+[1:n, 1:(n-1), 2:n], ... % block-2 row-3
    2*n+[1:n, 1:(n-1), 2:n], ... % block-4 row-3
    3*n+[1:n, 1:n, 1:n] ... % block-1-2-4 row-4
    ];
%% col ids
J = [1:n, 2:n, 1:(n-1), ... % block-1 row-1
    2*n+[1:n, 2:n, 1:(n-1)], ... % block-3 row-1
    1:n, n+[1:n], 2*n+[1:n], ... % block-1-2-3 row 2
    n+[1:n, 2:n, 1:(n-1)], ... % block-2 row-3
    3*n+[1:n, 2:n, 1:(n-1)], ... % block-4 row-3
    1:n, n+[1:n], 3*n+[1:n] ... % block-1-2-4 row-4
    ];
%% coefs
% row-1
i = 2:(n-1);
phi1 = phi(:,1);
x1 = x(:,1);
row1 = [...
    1; phi1(i+1)-2*phi1(i)+phi1(i-1); 1; ...
    0; phi1(i+1)-phi1(i); ...
    phi1(i-1)-phi1(i); 0; ...
    0; -(x1(i+1)+2*x1(i)+x1(i-1)); 0; ...
    0; x1(i+1)+x1(i); ...
    x1(i)+x1(i-1); 0];
% correct for mu==0
if(s1_idx < s2_idx)
    row1(s1_idx:s2_idx) = 0; % row-1 block-1 main diag
    row1(n+[s1_idx:s2_idx]) = 0; % row-1 block-1 upper diag
    row1(2*n+[s1_idx:s2_idx]) = 0; % row-1 block-1 lower diag
    
    row1(3*n-2+[s1_idx:s2_idx]) = 1; % row-1 block-3 main diag
    row1(4*n-2+[s1_idx:s2_idx]) = 0; % row-1 block-3 upper diag
    row1(5*n-2+[s1_idx:s2_idx]) = 0; % row-1 block-3 lower diag
end
% row-3
phi2 = phi(:,2);
x2 = x(:,2);
row3 = [...
    1; phi2(i+1) - 2*phi2(i) + phi2(i-1); 1; ...
    0; phi2(i+1) - phi2(i); ...
    phi2(i-1) - phi2(i); 0; ...
    0; -(x2(i+1)+2*x2(i)+x2(i-1)); 0; ...
    0; x2(i+1) + x2(i); ...
    x2(i) + x2(i-1); 0];
% correct for mu==0
if(s1_idx > s2_idx)
    row3(s2_idx:s1_idx) = 0; % row-1 block-1 main diag
    row3(n+[s2_idx:(s1_idx-1)]) = 0; % row-1 block-1 upper diag
    row3(2*n-2+[s2_idx:s1_idx]) = 0; % row-1 block-1 lower diag
    
    row3(3*n-2+[s2_idx:s1_idx]) = 1; % row-1 block-3 main diag
    row3(4*n-2+[s2_idx:(s1_idx-1)]) = 0; % row-1 block-3 upper diag
    row3(5*n-4+[s2_idx:s1_idx]) = 0; % row-1 block-3 lower diag
end
% row-2-4
dmu = dMU(x, data);
row2 = [...
    reshape(dmu(:,:,1), [], 1); -1*ones(n, 1)];
row4 = [...
    reshape(dmu(:,:,2), [], 1); -1*ones(n, 1)];
%% assemble matrix
A = sparse(I, J, [row1; row2; row3; row4], N, N, 18*N);
end

function b = make_rhs(x, phi, s1_idx, s2_idx, data, c1, c2)

n = max(s1_idx, s2_idx);
N = 4*n;
b = zeros(N, 1);
i = 2:(n-1);
i_full = 1:n;

%% row-1
phi1 = phi(:,1);
x1 = x(:,1);
b(1) = x1(1) - c1;
b(i) = ...
    (phi1(i+1)-phi1(i)).*(x1(i+1)+x1(i)) - ...
    (phi1(i)-phi1(i-1)).*(x1(i)+x1(i-1));
b(n) = x1(end) - data.sat.x1;
if(s1_idx < s2_idx)
    b(s1_idx:s2_idx) = phi1(s1_idx:s2_idx); % MU1(x(s1_idx:s2_idx,:), data);
end
%% row-3
phi2 = phi(:,2);
x2 = x(:,2);
b(2*n + 1) = x2(1) - c2;
b(2*n + i) = ...
    (phi2(i+1)-phi2(i)).*(x2(i+1)+x2(i)) - ...
    (phi2(i)-phi2(i-1)).*(x2(i)+x2(i-1));
b(2*n + n) = x2(end) - data.sat.x2;
if(s1_idx > s2_idx)
    b(2*n + [s2_idx:s1_idx]) = phi2(s2_idx:s1_idx); % MU2(x(s2_idx:s1_idx,:), data);
end
%% row-2-4
% b(n+i_full) = MU1(x, data) - phi1;
% b(3*n+i_full) = MU2(x, data) - phi2;
[b(n+i_full), b(3*n+i_full)] = MU(x, data);
b(n+i_full) = b(n+i_full) - phi1;
b(3*n+i_full) = b(3*n+i_full) - phi2;
%% finalize
b = -b;
end




