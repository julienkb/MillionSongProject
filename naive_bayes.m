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

nb = fitNaiveBayes(x, y);
c1 = nb.predict(x);
confusion = confusionmax(species, c1);