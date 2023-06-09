function [x] = inv_chem_pot(x, phi, data)
%% find x1 and x2 so that mu(x1,x2) == phi

mu = zeros(1,2);
for i = (size(x,1)-1):-1:2
    f = false; % do not have a correct guess yet
    % initial guess is from the closest point
    x(i,:) = x(i+1,:);
    % iterate through guesses
    while(~f)
        [mu(1,1), mu(1,2)] = MU(x(i,:), data);
        mu = mu - phi(i);
        dmu = dMU(x(i,:), data);
        
        dx = - 1*(dmu\mu')';
        
        g=true;
        while(g)
            if(x(i,1)<-dx(1))
                dx = dx/10;
            elseif(x(i,2)<-dx(2))
                dx = dx/10;
            elseif(x(i,1)+x(i,2) + sum(dx) > 1)
                dx = dx/10;
            else
                g = false;
            end
        end
        
        x(i,:) = min(1, max(0, x(i,:) + dx));
        f = all(abs(dx) < 1E-8);
    end
end
end