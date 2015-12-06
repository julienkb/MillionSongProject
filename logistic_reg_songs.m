matches = csvread('./cs229project/lists/match_indices.csv') + 1;
not_matches = csvread('./cs229project/lists/not_top_artist_indices.csv') + 1;
%indices = csvread('./match_indices.csv') + 1;

labels = ismembc(1:10000, matches)';
neg_labels = ismembc(1:10000, not_matches)';
include_in_data = logical(+labels +neg_labels);

labels = labels(include_in_data);
neg_labels = neg_labels(include_in_data);
y = +labels; % Convert from logical to int

load('song_info.mat');
x(isnan(x)) = 0;
%x = x(include_in_data, [1,3,4,6,7,9,10,11]);
x = x(include_in_data, [12:36]);
x = [ones(size(x, 1), 1) x];

%weights = 20 * (+labels) + 1 * (neg_labels);

precision1 = zeros(20, 1);
precision2 = zeros(20, 1);
recall1 = zeros(20, 1);
recall2 = zeros(20, 1);
num_pos = zeros(20, 1);

theta = zeros(size(x, 2), 1);
discount = [linspace(.001, 0, 1000)];
for iter = 1:100
    pred = +(sigmoid(theta'*x')' >= 0);
    c = (y - pred);

    grad = x' * c;
    theta = theta + .0000001 * grad;

    pred = +(sigmoid(theta'*x')' > 0);
    correct = (+pred - y == 0);

    precision1(iter) = sum (+correct(labels))  / sum (+pred);
    precision2(iter) = sum (+correct(~labels)) / (size(x,1) - sum(+pred));
    recall1(iter) = sum (+pred(labels)) / sum (y);
    recall2(iter) = sum (+~pred(~labels)) / (size(x,1) - sum(y));
    percent_pos(iter) = sum(+pred)/size(x,1);
end
percent_correct = sum(+correct)/(size(x,1));


plot(precision1, 'b');
hold on;
plot(precision2, 'g');
plot(recall1, 'r');
plot(recall2, 'k');
plot(percent_pos, 'g--');
legend('Pos. Precision1', 'Neg. Precision', 'Pos. Recall', 'Neg. Recall', 'num pos');