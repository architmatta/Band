%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main file to run the whole process
%This file is meant to process the data and find features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

[sound_train, sound_test] = get_data();
feature_train = zeros(size(sound_train, 2), 16);
feature_test = zeros(size(sound_test, 2), 16);

%% ==========Part 1: Find Feature and visualize============
for i = 1:size(sound_train, 2)
audiofile = sound_train(1, i);

%fprintf('Plotting the data....\n');
[output, LL, AA, FF, AiHn, mask, sortvals] = peakdet(audiofile);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

feature = calc_feat(LL, AA, FF, AiHn, mask, sortvals);
feature_train(i, :) = feature;
end;

for i = 1:size(sound_test, 2)
audiofile = sound_test(1, i);

%fprintf('Plotting the data....\n');
[output, LL, AA, FF, AiHn, mask, sortvals] = peakdet(audiofile);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

feature = calc_feat(LL, AA, FF, AiHn, mask, sortvals);
feature_test(i, :) = feature;
end;
%% ================= Part 2:   =============