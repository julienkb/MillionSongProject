matches = csvread('./cs229project/match_indices.csv') + 1;
not_matches = csvread('./cs229project/not_top_artist_indices.csv') + 1;
%indices = csvread('./match_indices.csv') + 1;

labels = ismembc(1:10000, matches)';
neg_labels = ismembc(1:10000, not_matches)';
include_in_data = logical(+labels +neg_labels);

labels = labels(include_in_data);
neg_labels = neg_labels(include_in_data);
y = +labels; % Convert from logical to int

load('song_info.mat');
x(isnan(x)) = 0;
genres = csvread('cs229project/lists/genres.csv');
x = [genres x];
x = x(include_in_data, [1:12]);
x = [ones(size(x, 1), 1) x];

theta = inv(x'*x) * (x' * y);

pred = (theta' * x' > 0)';
correct = (+pred == y);

precision1 = sum (+correct(labels))  / sum (+pred);
precision2 = sum (+correct(~labels)) / (size(x,1) - sum(+pred));
recall1 = sum (+pred(labels)) / sum (y);
recall2 = sum (+~pred(~labels)) / (size(x,1) - sum(y));

percent_correct = sum(+correct)/(size(x,1));
