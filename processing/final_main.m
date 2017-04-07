%This is the main file to run the whole process

%% Initialization
clear ; close all; clc

fprintf('This is the start......\n');
fprintf('If you want to get features, do something...\n');
pause;

[sound_train, train_output] = main();

fprintf('Feature collected.\n');
fprintf('If you gotta train, why wait?\n');
pause;

net = nnet_simple(sound_train, train_output);

fprintf('Well! Network is trained.\n');
fprintf('Now enter file path you want to test it on.\n');
audiofile = input('File:', 's');

[output, tym] = full_sound_file(audiofile, net);

fprintf('The tym array contains time at which horn is present.\n');