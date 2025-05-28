% 最小生成树求解：破圈法和避圈法
clear; clc;

% 定义无向图：8个节点，13条边
s = [1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 7]; % 源节点
t = [2, 3, 4, 7, 3, 5, 8, 4, 5, 6, 6, 7, 6, 8, 7, 8, 8]; % 目标节点
weights = [7, 8, 2, 3, 1, 2, 3, 4, 2, 7, 4, 6, 5, 1, 4, 3, 6]; % 边权
G = graph(s, t, weights);
n = 8; % 节点数

% 方法1：避圈法
T = minspantree(G);
total_weight = sum(T.Edges.Weight);
fprintf('避圈法（Prim算法）求解结果：\n');
fprintf('最小生成树边：\n');
disp(T.Edges);
fprintf('总权值：%.2f\n\n', total_weight);

% 方法2：破圈法
% 按边权从大到小排序
[~, idx] = sort(G.Edges.Weight, 'descend');
sorted_edges = G.Edges(idx, :);
current_graph = G;
num_edges_to_keep = n - 1; % 最小生成树边数
i = 1;
while current_graph.numedges > num_edges_to_keep
    edge_to_remove = sorted_edges(i, :);
    u = edge_to_remove.EndNodes(1);
    v = edge_to_remove.EndNodes(2);
    temp_graph = rmedge(current_graph, u, v);
    % 检查移除边后图是否仍连通
    bins = conncomp(temp_graph);
    if max(bins) == 1 % 图仍连通
        current_graph = temp_graph;
    end
    i = i + 1;
end
total_weight_b = sum(current_graph.Edges.Weight);
fprintf('破圈法（反向删除法）求解结果：\n');
fprintf('最小生成树边：\n');
disp(current_graph.Edges);
fprintf('总权值：%.2f\n\n', total_weight_b);

% 可视化
figure;
subplot(1, 2, 1);
plot(G, 'EdgeLabel', G.Edges.Weight, 'NodeLabel', 1:n);
title('原始图');
subplot(1, 2, 2);
plot(T, 'EdgeLabel', T.Edges.Weight, 'NodeLabel', 1:n);
title('最小生成树');