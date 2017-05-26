%run the whole process of training once
function[net, mean_train, dev_train, epochs, msret, msrev, msretest, time,...
                num_input, num_hidden, num_output] = train_one_time()
frame_length = 50;
frame_shift = 25;
alpha = 0.97;
window = @hanning;
R = [300 5000]; %frequency range
M = 26; % number of filterbank channels
N = 20; % number of mfcc
L = 22; % liftering coefficient

tic
[sound_train, train_output] = main(frame_length, frame_shift, alpha, window, R, M, N, L);
mean_train = mean(sound_train);
dev_train = std(sound_train);

for i = 1:size(sound_train)
    sound_train(i, :) = (sound_train(i, :)-mean_train(1, :))./dev_train;
end

[net, tr, epochs] = nnet_simple(sound_train, train_output);

time = toc;

Iw = cell2mat(net.IW);
Lw = cell2mat(net.LW);

msret = tr.perf(end);
msrev = tr.vperf(end);
msretest = tr.tperf(end);
num_input = size(Iw, 2);
num_hidden = size(Iw, 1);
num_output = size(Lw, 1);
