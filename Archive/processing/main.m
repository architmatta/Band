%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main file to run the whole process
%This file is meant to process the data and find features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

[sound_train, sound_test] = get_data();
feature_train = zeros(size(sound_train, 1), 16);
feature_test = zeros(size(sound_test, 1), 16);

%% ==========Part 1: Find Feature and visualize============
for i = 1:size(sound_train, 1)
audiofile = sound_train(i, :);
tic
%fprintf('Plotting the data....\n');
[output, LL, AA, FF, AiHn, mask, sortvals] = peakdet(audiofile);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

feature = calc_feat(LL, AA, FF, AiHn, mask, sortvals);
feature_train(i, :) = real(feature);
t(i) = toc
end;

for i = 1:size(sound_test, 1)
audiofile = sound_test(i, :);

%fprintf('Plotting the data....\n');
[output, LL, AA, FF, AiHn, mask, sortvals] = peakdet(audiofile);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

feature = calc_feat(LL, AA, FF, AiHn, mask, sortvals);
feature_test(i, :) = real(feature);
end;
%% ================= Part 2:   =============
mahal_dist = mahal(feature_test, feature_train);
%mean_dist = sum((feature_test-repmat(mean(feature_train),4,1)).^2, 2);

%scatter(feature_train(:,1),feature_train(:,2))
%hold on
%scatter(Y(:,1),Y(:,2),100,d1,'*','LineWidth',2)
%hb = colorbar;
%ylabel(hb,'Mahalanobis Distance')
%legend('X','Y','Location','NW');
