% 非线性规划问题求解
clear; clc;

% 定义目标函数
fun = @(x) -(-x(1)^2 + 5*x(1) - x(2)^2 + 7*x(2) - 5); % 负号转为最小化

% 初始点
x0 = [0; 0];

% 线性约束
A = [4, 1; 1, 4];
b = [20; 20];

% 上下界
lb = [0; 0];
ub = [Inf; Inf];

% 求解
options = optimoptions('fmincon', 'Display', 'iter');
[x, fval] = fmincon(fun, x0, A, b, [], [], lb, ub, [], options);

% 输出结果
fprintf('最优促销水平：x1 = %.2f, x2 = %.2f\n', x(1), x(2));
fprintf('最大总收入：%.2f 百万元\n', -fval);
