% 定义有向图
% 源节点
s = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5];
% 目标节点
t = [2, 3, 4, 6, 4, 5, 5, 6, 6, 3];
% 边权
weights = [1, 2, 3, 7, 3, 2, 2, 3, 6, 2];
% 创建有向图
G = digraph(s, t, weights);
% 计算从v1到v6的最短路径
[path, d] = shortestpath(G, 1, 6);
% 显示结果
disp('最短路径:');
disp(path);
disp('总距离:');
disp(d);