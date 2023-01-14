function [X1,X2,X3] = phaseDiagram(data)
lw = 2;

appr = 0.005;
[X1,X2,X3] = phase3equilib(data, appr, appr);


x1 = linspace(0,0.02,101);
x2 = linspace(0,0.02,101);
[x1, x2] = meshgrid(x1,x2);
x1(x1+x2>1) = NaN;
x2(isnan(x1)) = NaN;

mu1 = zeros(size(x1));
mu2 = mu1;
for p = 1:size(x1, 2)
[mu1(:,p), mu2(:,p)] = MU([x1(:,p), x2(:,p)], data);
end

figure(1546)
hold on
axis equal
axis tight
axis([0 0.02 0 0.02])
% axis([0 0.1 0 0.1])
xlabel('{\itx}_1')
ylabel('{\itx}_2')
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


figure(1546)
contour(x1, x2, mu1, -1:0.2:1);
contour(x1, x2, mu2, -1:0.2:1);
M1 = contour(x1, x2, mu1, [0,0], 'k', 'linewidth', 2);
M2 = contour(x1, x2, mu2, [0,0], 'k', 'linewidth', 2);
% close 2

figure(1546)
plot([0 1], [1 0], 'k', 'LineWidth', 1)

% x3 = [X1; 1; 0];
% y3 = [X2; 0; 1];



nmbr = M1(2,1);
M1 = M1(:,2:(nmbr+1));
% nmbr = M1(2,1);
%M1(:, (nmbr+2):end) = [];
%M1(:, 1) = [];
M1(:,M1(2,:)>X2) = [];
M1(:,M1(1,:)>X1) = [];
plot(M1(1,:), M1(2,:), 'r', 'LineWidth', lw)

% for i = 1:8:size(M1,2)
% plot([1,M1(1,i)], [0,M1(2,i)], 'k--', 'LineWidth', lw/2) 
% end



nmbr = M2(2,1);
M2 = M2(:,2:(nmbr+1));
% nmbr = M2(2,1);
% M2(:, (nmbr+2):end) = [];
% M2(:, 1) = [];
M2(:,M2(1,:)>X1) = [];
M2(:,M2(2,:)>X2) = [];
plot(M2(1,:), M2(2,:), 'b', 'LineWidth', lw)

% for i = 1:8:size(M2,2)
% plot([0,M2(1,i)], [1,M2(2,i)], 'k--', 'LineWidth', lw/2) 
% end



% patch(x3,y3, [220,220,220]/256, 'LineWidth', lw)
plot(X1, X2, 'ks', 'MarkerFaceColor', 'green', 'MarkerSize', 9)
plot([data.xSat1, 0], [0, data.xSat2], 'ko', 'MarkerFaceColor', 'green', 'MarkerSize', 8)


% figName = 'figure_2';
% 
% saveas(gca, [figName], 'eps')
% saveas(gca, [figName], 'emf')
% saveas(gca, [figName], 'fig')
% saveas(gca, [figName], 'jpg')


end
