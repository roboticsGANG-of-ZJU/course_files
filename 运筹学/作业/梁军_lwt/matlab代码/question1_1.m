% 服装加工厂整数规划问题求解
clear; clc;

% 定义参数
m = 5; % 车间数
n = 6; % 布料种类
total_var = m * n; % 总变量数

% 利润矩阵 r_ij (5x6)
R = [4, 3, 4, 4, 5, 6;
     3, 4, 5, 3, 4, 5;
     5, 3, 4, 5, 5, 4;
     3, 3, 4, 4, 6, 6;
     3, 3, 3, 4, 5, 7];

% 布料单价 c_j
c = [6, 6, 7, 8, 9, 10];

% 目标函数系数 (最大化转为最小化)
f = -R(:); % 展平为30x1向量，负号因为intlinprog最小化

% 约束矩阵 A 和 b
A = zeros(m+1, total_var); % 1个预算约束 + 5个车间约束
b = zeros(m+1, 1);

% 预算约束
A(1, :) = repmat(c, 1, m); % 每个x_ij对应c_j
b(1) = 400000;

% 车间容量约束
for i = 1:m
    start_idx = (i-1)*n + 1;
    end_idx = start_idx + n - 1;
    A(i+1, start_idx:end_idx) = ones(1, n);
    b(i+1) = 10000;
end

% 上下界
lb = 1000 * ones(total_var, 1); % x_ij >= 1000
ub = inf(total_var, 1);

% 整数约束
intcon = 1:total_var; % 所有变量为整数

% 求解
[x, fval] = intlinprog(f, intcon, A, b, [], [], lb, ub);

% 输出结果
x = reshape(x, [n, m])'; % 转换为5x6矩阵
total_profit = -fval; % 最大利润
fprintf('最大总利润: %.2f 元\n', total_profit);
disp('布料分配方案 (x_ij, 单位: 米):');
disp(x);

% 每种布料购买量
fabric_amount = sum(x, 1);
fprintf('每种布料购买量 (米):\n');
for j = 1:n
    fprintf('布料 %d: %.2f 米\n', j, fabric_amount(j));
end