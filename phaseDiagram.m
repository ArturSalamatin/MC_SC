function phaseDiagram(data)
global phaseEqId figureSaver componentsSpecs phaseEqSpecs

if(~isempty(phaseEqId))
    
    x1 = linspace(0,phaseEqSpecs.scale,501);
    x2 = linspace(0,phaseEqSpecs.scale,501);
    [x1, x2] = meshgrid(x1,x2);
    x1(x1+x2>1) = NaN;
    x2(isnan(x1)) = NaN;
    
    [mu1, mu2] = MU([x1(:), x2(:)], data);
    mu1 = reshape(mu1, size(x1));
    mu2 = reshape(mu2, size(x2));
    
    figure(phaseEqId)
    
    grayColor = [1 1 1]*0.9;
    patch([data.sat.x1 1 0], [data.sat.x2 0 1], ...
        grayColor);
    contour(x1, x2, mu1, -1:0.2:1);
    contour(x1, x2, mu2, -1:0.2:1);
    plot([0 1], [1 0], 'k', 'LineWidth', 1)
    
    plot(data.curve1.x1, data.curve1.x2, ...
        componentsSpecs.color1, 'LineWidth', componentsSpecs.lw)
    plot(data.curve2.x1, data.curve2.x2, ...
        componentsSpecs.color2, 'LineWidth', componentsSpecs.lw)
    
    plot(data.sat.x1, data.sat.x2, ...
        'ks', 'MarkerFaceColor', phaseEqSpecs.markerFaceColor, ...
        'MarkerSize', phaseEqSpecs.markerSize)
    plot([data.xSat1, 0], [0, data.xSat2], ...
        'ko', 'MarkerFaceColor', phaseEqSpecs.markerFaceColor, ...
        'MarkerSize', phaseEqSpecs.markerSize)
    
    if(figureSaver.isSave)
        saveas(gca, [figureSaver.folder, figureSaver.phaseDiagFigName], 'eps')
        saveas(gca, [figureSaver.folder, figureSaver.phaseDiagFigName], 'emf')
        saveas(gca, [figureSaver.folder, figureSaver.phaseDiagFigName], 'fig')
        saveas(gca, [figureSaver.folder, figureSaver.phaseDiagFigName], 'jpg')
    end
end




end
