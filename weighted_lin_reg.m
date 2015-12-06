matches = csvread('./cs229project/lists/match_indices.csv') + 1;
not_matches = csvread('./cs229project/lists/not_top_artist_indices.csv') + 1;
%indices = csvread('./match_indices.csv') + 1;

labels = ismembc(1:10000, matches)';
neg_labels = ismembc(1:10000, not_matches)';
% All examples to use
include_in_data = logical(+labels +neg_labels); 

% Recalculate labels, neg_labels since examples removed
labels = labels(include_in_data);
neg_labels = neg_labels(include_in_data);
y = +labels; % Convert from logical to int

% Load the training data
load('song_info.mat');
x(isnan(x)) = 0;
genres = csvread('cs229project/lists/genres.csv');
x = [genres x];
x = x(include_in_data, 12:36);
x = [ones(size(x, 1), 1) x];


recall1 = zeros(20, 1);
recall2 = zeros(20, 1);
precision1 = zeros(20, 1);
precision2 = zeros(20, 1);


% Run the program with different weights
for weight = 1:20
    weights = weight * (+labels) + 1 * (neg_labels);
    %pred_true = zeros(20, 1);
    theta = zeros(size(x, 2), 1);
    discount = [linspace(1, .01, 200) linspace(.01, 0, 600)];
    for iter = 1:800
        pred = ((theta'*x')' > 0);
        grad = weights.* (y - pred);
        %pred_true(iter) = sum(+pred);
        theta = theta + discount(iter) * x' * grad;
    end

    pred = (theta' * x' > 0)';
    correct = (+pred == y);

    precision1(weight) = sum (+correct(labels))  / sum (+pred);
    precision2(weight) = sum (+correct(~labels)) / (size(x,1) - sum(+pred));
    recall1(weight) = sum (+pred(labels)) / sum (y);
    recall2(weight) = sum (+~pred(~labels)) / (size(x,1) - sum(y));

    percent_correct = sum(+correct)/(size(x,1));
end

plot(precision1, 'b');
hold on;
plot(precision2, 'g');
plot(recall1, 'r');
plot(recall2, 'k');
% plot(pred_true);