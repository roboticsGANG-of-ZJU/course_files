% 多阶段利润优化问题动态规划求解（示例框架）
clear; clc;

% 示例参数（需替换为具体g、h函数和参数）
n = 3; % 阶段数
x1 = 100; % 初始原料量
a = 0.5; % 产品A回收率
b = 0.3; % 产品B回收率
g = @(y) y^0.5; % 示例利润函数g
h = @(y) 2*y^0.5; % 示例利润函数h

% 状态空间离散化
x_max = x1;
x_grid = 0:0.1:x_max;
V = zeros(length(x_grid), n+1); % 价值函数

% 动态规划：从后向前
for k = n:-1:1
    for i = 1:length(x_grid)
x = x_grid(i);
y_vals = 0:0.1:x; % 离散化y
profits = zeros(size(y_vals));
for j = 1:length(y_vals)
    y = y_vals(j);
    if k == n
profits(j) = g(y) + h(x - y); % 最后阶段
    else
x_next = a*y + b*(x - y);
[~, idx] = min(abs(x_grid - x_next));
profits(j) = g(y) + h(x - y) + V(idx, k+1);
    end
end
[V(i, k), idx] = max(profits);
    end
end

% 输出结果
[max_profit, idx] = max(V(:, 1));
fprintf('最大总利润：%.2f\n', max_profit);
fprintf('初始原料量：%.2f\n', x_grid(idx));