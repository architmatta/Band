%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main file to run the whole process
%This file is meant to process the data and find features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

%% ==========Part 1: Plot the data and choose peaks============

audiofile = '..\data\vehicle040.wav';

fprintf('Plotting the data....\n');
[output,LL, AA, FF, AiHn, mask] = peakdet(audiofile);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =================== Part 2:   ===================
%calculate features

%% ================= Part 3: Features  =============




