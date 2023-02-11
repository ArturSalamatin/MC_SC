global lw
lw = 2;
fntSize = 14;
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', fntSize);
set(0,'defaultTextFontName', 'Times New Roman')
set(0,'defaultTextFontSize', fntSize)

global phaseEqId concDistribId muDistribId fluxDistribId
global flux1_PlotId flux2_PlotId fluxFrac_PlotId fluxSum_PlotId
global gibbsId
global concDistrib
global componentsSpecs figureSaver phaseEqSpecs
global test_phiDistribId test_concDistribId

componentsSpecs.color2 = 'b';
componentsSpecs.color1 = 'r';
componentsSpecs.lw = 2;

phaseEqSpecs.marker3Phase = 'ks';
phaseEqSpecs.markerFaceColor = 'green';
phaseEqSpecs.markerSize = 9;
phaseEqSpecs.scale = 0.01;

figureSaver.isSave = false;
figureSaver.phaseDiagFigName = 'figure_2';
%%
phaseEqId = randsample(2000:9000,1);
if(~isempty(phaseEqId))
    concDistrib.color = 'k';
    concDistrib.lw = 2;
    figure(phaseEqId)
    hold on
    box on
    axis equal
    axis tight
    axis([0 phaseEqSpecs.scale 0 phaseEqSpecs.scale])
    % axis([0 0.1 0 0.1])
    xlabel(['{\itx}_1, ' char(8211)])
    ylabel(['{\itx}_2, ' char(8211)])
    % annotation('textbox',...
    %     [0.448214285714285 0.425190477751552 0.0633928557857871 0.0761904746294022],...
    %     'String',{'3'},...
    %     'LineStyle','none');
    % annotation('textbox',...
    %     [0.246428571428571 0.14185714441822 0.0633928557857871 0.0761904746294022],...
    %     'String',{'1'},...
    %     'LineStyle','none');
    % annotation('arrow',[0.373214285714286 0.280357142857143],...
    %     [0.306142857142857 0.295238095238095]);
    % annotation('arrow',[0.403571428571429 0.417857142857143],...
    %     [0.275190476190476 0.161904761904762]);
    % annotation('textbox',...
    %     [0.374999999999998 0.270428572989649 0.0633928557857871 0.0761904746294023],...
    %     'String','2',...
    %     'LineStyle','none',...
    %     'FitBoxToText','off');
end
%%
flux1_PlotId = 3248;
if(~isempty(flux1_PlotId))
    figure(flux1_PlotId)
    hold on
    grid on
    box on
%    axis([0 1 0 1])
    xlabel(['{\its}_2/{\its}_1, ' char(8211)])
    ylabel(['{\itJ}_1/{\itJ^{sc}}_1, {\itJ}_2/{\itJ^{sc}}_2, ' char(8211)])
end
%%
flux2_PlotId = 3249;
if(~isempty(flux2_PlotId))
    figure(flux2_PlotId)
    hold on
    grid on
    box on
%    axis([0 1 0 1])
    xlabel(['{\its}_2/{\its}_1, ' char(8211)])
    ylabel(['{\itJ}_2/{\itJ^{sc}}_2, ' char(8211)])
end

%%
fluxSum_PlotId = 3247;
if(~isempty(fluxSum_PlotId))
    figure(fluxSum_PlotId)
    hold on
    grid on
    box on
%    axis([0 1 0 1])
    xlabel(['{\its}_2/{\its}_1, ' char(8211)])
    ylabel(['{\itJ}_{12}/{\itJ^{sc}}_{12}, ' char(8211)])
end
%%
fluxFrac_PlotId = 3246;
if(~isempty(fluxFrac_PlotId))
    figure(fluxFrac_PlotId)
    hold on
    grid on
    box on
%    axis([0 1 0 1])
    xlabel(['{\its}_2/{\its}_1, ' char(8211)])
    ylabel(['{\itJ_i}/{\itJ}_{12}, ' char(8211)])
end

%%
concDistribId = 1248;
if(~isempty(concDistribId))
    figure(concDistribId)
    hold on
    grid on
    box on
    set(gca, 'XDir','reverse')
    xlabel(['{\itz}/{\itas}_1, ' char(8211)])
    ylabel(['{\itx}_1, {\itx}_2, ' char(8211)])
end
%%
muDistribId = 1249;
if(~isempty(muDistribId))
    figure(muDistribId)
    hold on
    grid on
    box on
    axis([0 1 -3 0])
    set(gca, 'XDir','reverse')
    xlabel(['{\itz}/{\itas}_1, ' char(8211)])
    ylabel(['{\it\mu}_{\iti}/{\itRT}, ' char(8211)])
end
%%
fluxDistribId = 1250;
if(~isempty(fluxDistribId))
    figure(fluxDistribId)
    hold on
    grid on
    box on
 %   axis([0 1 -3 0])
    set(gca, 'XDir','reverse')
    xlabel(['{\itz}/{\itas}_1, ' char(8211)])
    ylabel(['{\itj}_{\iti}, ' char(8211)])
end

%%
% test_concDistribId = 4357;
if(~isempty(test_concDistribId))
    figure(test_concDistribId)
    hold on
    title('Newton trials of conc')
end
% test_phiDistribId = 4358;
if(~isempty(test_phiDistribId))
    figure(test_phiDistribId)
    hold on
    title('Newton trials of phi')    
end


gibbsId = 12;
if(~isempty(gibbsId))
    figure(gibbsId)
    hold on
    box on
    grid on
    xlabel(['{\itx}_1, ' char(8211)])
    ylabel(['{\itx}_2, ' char(8211)])
    zlabel(['{\itG}/{\itRT}, ' char(8211)])
    view([-61.0902627173864 24.1210497640916]);
end