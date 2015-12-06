% Read in the data
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
genres = csvread('cs229project/lists/genres.csv');
x = [genres x];
x = x(include_in_data, [17:71 73:113]);

% Train algorithm
SVMModel = fitcsvm(x,y,'KernelFunction','linear','Standardize', true);
pred = predict(SVMModel, x);
% c1 = qda.predict(x);
% confusion = confusionmat(y, c1)


% Output predictions/stats
num_examples = size(x, 1);
pred_pos = confusion(1, 2) + confusion(2, 2);
pred_neg = confusion(1, 1) + confusion(2, 1);

recall_pos = confusion(2,2) / sum(y)
recall_neg = confusion(1,1) / sum(+neg_labels)
precision_pos = confusion(2, 2)/pred_pos
precision_neg = confusion(1, 1)/pred_neg