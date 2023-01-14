function [x2] = inv_chem_pot2(x1, x2, phi2, data)
%% find x1 and x2 so that mu(x1,x2) == phi


for i = 1:length(x1)
f = false;
    while(~f)
        mu2 = MU2(x1(i), x2(i), data);
        mu2 = mu2 - phi2(i);
        dmu2 = dMU2(x1(i), x2(i), data);
        
        dx = - dmu2\mu2;
        
%         g = true;
%         while(g)
%             if(x2(i)<-dx)
%                 dx = dx/10;
%             elseif(x1(i)+x2(i) + dx > 1)
%                 dx = dx/10;
%             else
%                 g = false;
%             end
%         end
        
        x2(i) = min(1, max(0, x2(i) + dx(2)));
        
        f = all(abs(dx) < 1E-8);
        
    end
end

end