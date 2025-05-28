clear;clc;
% 定义开环传递函数GH（K=2A为根轨迹参数）
num = [1 8 20];          % 分子多项式s²+8s+20
den = conv(conv([1 0], [1 4]), [1 2]); % 分母s(s+4)(s+2)
sys_open = tf(num, den); % 开环传递函数K*(s²+8s+20)/(s^3+6s²+8s)

% 生成高密度根轨迹数据（提高计算精度）
K_values = logspace(-2, 4, 10000);  % 生成10000个对数分布的增益值
[r, K] = rlocus(sys_open, K_values);

% 初始化最小阻尼比参数
min_xi = Inf;    % 初始化最小阻尼比
optimal_K = NaN; % 最优增益
optimal_A = NaN; % 最优放大系数

% 遍历所有增益点寻找最小阻尼比
for i = 1:length(K)
    poles = r(:,i);  % 当前增益对应的所有极点
    
    % 提取复数极点（虚部非零）
    complex_poles = poles(imag(poles) > 0);  % 仅取上半平面避免重复
    
    for pole = complex_poles'
        sigma = real(pole);
        omega = imag(pole);
        xi = -sigma / sqrt(sigma^2 + omega^2);  % 计算阻尼比
        
        % 更新最小值
        if xi < min_xi
            min_xi = xi;
            optimal_K = K(i);
            optimal_A = optimal_K / 2;  % K=2A关系转换
            optimal_pole = pole;       % 记录极点位置
        end
    end
end

% 绘制根轨迹和最优极点标记
figure;
rlocus(sys_open); hold on;
plot(real(optimal_pole), imag(optimal_pole), 'ro', 'MarkerSize',10, 'LineWidth',2);
plot(real(optimal_pole), -imag(optimal_pole), 'ro', 'MarkerSize',10, 'LineWidth',2);
sgrid;
title(['Root Locus | Minimum ξ=', num2str(min_xi, '%.3f'), ' at A=', num2str(optimal_A, '%.3f')]);
xlabel('Real Axis'); ylabel('Imaginary Axis');

% 构建闭环传递函数
s = tf('s');
G = (10*optimal_A*(s^2 + 8*s + 20))/(s*(s + 4));
H = 0.2/(s + 2);
sys_closed = feedback(G, H);  % 闭环传递函数

% 转换为零极点增益形式
sys_closed_zpk = zpk(sys_closed);

% 显示结果
disp('===== 计算结果 =====');
disp(['最小阻尼比 ξ = ', num2str(min_xi, '%.4f')]);
disp(['对应增益 K = ', num2str(optimal_K, '%.4f')]);
disp(['放大系数 A = ', num2str(optimal_A, '%.4f')]);
disp('闭环传递函数零极点增益形式：');
sys_closed_zpk