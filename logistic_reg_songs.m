indices = csvread('./cs229project/match_indices.csv') + 1;
%indices = csvread('./match_indices.csv') + 1;

labels = ismembc(1:10000, indices)';
y = +labels; % Convert from logical to int

load('song_data.mat');
x(isnan(x)) = 0;

x = x(:, [9, 12, 13]);

% theta = zeros(size(x, 2), 1);
% for iter = 1:2
%     t = (sigmoid(theta'*x')' > 0);
%     z = y - t;
%     grad = x' * (y - t);
%     theta = theta + 0.001 * grad;
% end
det(x' *x);
theta = inv(x'*x) * (x' * y);

pred = (theta' * x' > 1)';
correct = (+pred - y == 0);

precision1 = sum (+correct(labels))  / sum (+pred);
precision2 = sum (+correct(~labels)) / (10000 - sum(+pred));
recall1 = sum (+pred(labels))  / sum (y);
recall2 = sum (+~pred(~labels)) / (10000 - sum(y));

percent_correct = sum(+correct)/10000;
