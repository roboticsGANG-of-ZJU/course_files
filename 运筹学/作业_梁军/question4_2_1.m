% 0-1背包问题求解（显枚举法）
clear; clc;

% 参数定义
n = 5; % 物品总数
b = 10; % 背包最大承重
a = [2, 3, 4, 5, 6]; % 物品重量
c = [3, 4, 5, 6, 7]; % 物品价值

% 初始化变量
max_val = 0; % 最大价值
best_comb = []; % 最优组合

% 枚举所有可能的组合
for i = 0:2^n - 1
    comb = zeros(1,n); % 当前组合
    for j = 1:n
        comb(j) = bitget(i,j); % 使用bitget获取二进制表示
    end
    total_weight = sum(a .* comb); % 计算总重量
    if total_weight <= b % 如果总重量不超过背包容量
        total_value = sum(c .* comb); % 计算总价值
        if total_value > max_val % 更新最大价值和最优组合
            max_val = total_value;
            best_comb = comb;
        end
    end
end

% 输出结果
fprintf('最大价值: %d\n', max_val);
fprintf('选中的物品: ');
for j = 1:n
    if best_comb(j) == 1
        fprintf('%d ', j);
    end
end
fprintf('\n');