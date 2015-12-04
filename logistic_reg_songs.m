indices = csvread('../CS229/MillionSongProject/match_indices.csv') + 1;

y = ismembc(1:10000, indices)';
y = +y; % Convert from logical to int
% theta = (x'*x) \ x' * y;
theta = zeros(size(x, 2), 1);
for iter = 1:2
    t = sigmoid(theta'*x')';
    z = y-t;
    grad = x' * (y - t);
    theta = theta + grad;
end