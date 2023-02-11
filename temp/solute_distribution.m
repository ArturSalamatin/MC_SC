function [x,phi] = solute_distribution(x, phi,...
    s1_idx, s2_idx, data)

eps = 1E-4;
% here a Laplace equation is solved for every component
tr_zone_1 = 1:s1_idx;
tr_zone_2 = 1:s2_idx;

while(true)
    
    figure(4357)
    hold off
    plot(x(:,1), 'r', 'linewidth', 2)
    hold on
    plot(x(:,2), 'b', 'linewidth', 2)
    figure(4358)
    hold off
    plot(phi(:,1), 'r', 'linewidth', 2)
    hold on
    plot(phi(:,2), 'b', 'linewidth', 2)
    
    % chemical potential of core-component is zero
    % where the core intersects witht the transport zone of the other
    % component
    if(s1_idx > s2_idx)
        phi(s1_idx:s2_idx, 1) = 0;
    else
        phi(s1_idx:s2_idx, 2) = 0;
    end
    %% save previous guess
    phi_prev = phi;
    x_prev = x;
    %% calculate new mu-guess based on previous x-guess
    % solve Laplace eqaution in a corresponding transport zone
    if(s1_idx > 2)
        phi(tr_zone_1,1) = laplace(x(tr_zone_1,1), phi_prev([1,s1_idx],1));
    end
    if(s2_idx > 2)
        phi(tr_zone_2,2) = laplace(x(tr_zone_2,2), phi_prev([1,s2_idx],2));
    end
    
    figure(4358)
    hold off
    plot(phi(:,1), 'r', 'linewidth', 2)
    hold on
    plot(phi(:,2), 'b', 'linewidth', 2)
    
    
    % correct the mu-value in the core-transport zone
    if(s1_idx > s2_idx)
        phi(s2_idx:s1_idx, 1) = 0;
    else
        phi(s1_idx:s2_idx, 2) = 0;
    end
    %% update the x-guess
    x = inv_chem_pot(x, phi, data);
    %% check convergence
    if(     all(all(abs(x-x_prev)<=x*eps)) && ...
            all(all(abs(phi-phi_prev)<=abs(phi)*eps)) ...
            )
        break;
    end
    

end
%
%     figure(4357)
%     hold on
%     plot(x1)
%     plot(x2)
end