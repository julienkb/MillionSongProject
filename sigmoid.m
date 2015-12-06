function [v] = sigmoid(scores)
v = ones(size(scores))./(1 + exp(-scores));