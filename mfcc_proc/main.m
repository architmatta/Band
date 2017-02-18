%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main file to run the whole process
%This file is meant to process the data and find features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

[sound_train, sound_test] = get_data();
audiofile = sound_train(1, :)

%% ==========Part 1: Find Feature and visualize============


