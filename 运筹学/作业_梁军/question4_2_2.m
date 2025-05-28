dp = zeros(n+1, b+1); % 初始化dp表
for i = 1:n
    for w = 0:b
        idx_w = w + 1; % MATLAB索引从1开始
        if a(i) > w
            dp(i+1, idx_w) = dp(i, idx_w); % 不能携带第i件物品
        else
            take = dp(i, idx_w - a(i)) + c(i); % 携带第i件物品
            not_take = dp(i, idx_w); % 不携带第i件物品
            dp(i+1, idx_w) = max(take, not_take); % 取最大值
        end
    end
end
max_val_dp = dp(n+1, b+1); % 获取最大价值
fprintf('动态规划法最大价值: %d\n', max_val_dp);