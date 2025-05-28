% 时间区间
t1 = 0:0.01:3; % 从0到3秒，步长为0.01秒
t2 = 3:0.01:5; % 从3到5秒，步长为0.01秒

% 定义第一个式子
phi1 = @(t) 5/12*t.^2 - 35/108*t.^3 + 5; % 0 <= t <= 3

% 定义第二个式子
phi2 = @(t) 45/4 + (t - 3) + 5/2*(t - 3).^2 - 45/16*(t - 3).^3; % 3 < t <= 5

% 谷物器：合并两个时间区间的数据
t = [t1 t2]; % 合并时间
phi = [phi1(t1) phi2(t2)]; % 合并位置

% 计算一阶导数
phi1_diff = @(t) (5/6)*t - (35/36)*t.^2; % 第一个式子的导数
phi2_diff = @(t) 1 + (5/2)*(t - 3) - (45/16)*3*(t - 3).^2; % 第二个式子的导数
phi_diff = [phi1_diff(t1) phi2_diff(t2)]; % 合并导数

% 计算二阶导数
phi1_diff2 = @(t) 5/6 - (35/18)*t; % 第一个式子的二阶导数
phi2_diff2 = @(t) (5/2) - (45/16)*6*(t - 3); % 第二个式子的二阶导数
phi_diff2 = [phi1_diff2(t1) phi2_diff2(t2)]; % 合并二阶导数

% 绘制机器人关节角图
figure;
plot(t, phi, 'LineWidth', 1.5);
title('机器人关节角 \phi(t)');
xlabel('时间 (s)');
ylabel('关节角 (°)');
grid on;

% 绘制一阶导数图
figure;
plot(t, phi_diff, 'LineWidth', 1.5, 'r');
title('一阶导数 \phi''(t)');
xlabel('时间 (s)');
ylabel('关节角导数 (°/s)');
grid on;

% 绘制二阶导数图
figure;
plot(t, phi_diff2, 'LineWidth', 1.5, 'g');
title('二阶导数 \phi'''(t)');
xlabel('时间 (s)');
ylabel('关节角二阶导数 (°/s²)');
grid on;
