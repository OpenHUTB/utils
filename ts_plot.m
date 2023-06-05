function ts_plot(com_sim_path, cur_dir)
% 绘制PCA成分数和神经相似性之间的关系图

data = load(com_sim_path);  % 加载已经生成的数据用于绘图
data = data.comp_sim;

orange = [ 0.91,0.41,0.17];
blue = [0,0.4470,0.7410];
figure('DefaultAxesFontSize',14);
ax = gca;

hold on
h1 = plot(data(:,1), data(:,2), '-', 'color',orange, 'linewidth',3, 'DisplayName','rmse');
h1 = plot(data(:,1), data(:,3), '-', 'color',blue, 'linewidth',3, 'DisplayName','rmse');
xlabel('PCA component');
ylabel('Normalized Value [0, 1]');

ylim([-0.1 1.1])
legend('neural similarity', 'p value', 'Location', 'east');

box on;
grid on;

ax.GridLineStyle = '-.';
set(gcf, 'PaperSize', [8 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 8 6]);

set(gca, 'XTick', 0:20:160)

img_dir = fullfile(cur_dir, 'latex', 'figs');
if ~exist(img_dir, 'dir'); mkdir(img_dir); end
saveas(gcf, fullfile(img_dir, 'comp_sim.pdf'),'pdf');

close all
end