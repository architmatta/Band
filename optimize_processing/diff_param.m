clear all; clc; 
%run the whole process n no.
frame_length = 50;
frame_shift = 25;
alpha = 0.97;
window = @hanning;
R = [300 5000]; %frequency range
M = 26; % number of filterbank channels
N = 20; % number of mfcc
L = 22; % liftering coefficient

frame_len_vec = [];
frame_shift_vec = [];
alpha_vec = [];
M_vec = [];
N_vec = [];
L_vec = [];
num_input_vec = [];
num_hidden_vec = [];
num_output_vec = [];
msre_train = [];
msre_val = [];
msre_test = [];
epoch_vec = [];
time_train_vec = [];
time_feat_vec = [];

frame_len_vec_mean = [];
frame_shift_vec_mean = [];
alpha_vec_mean = [];
M_vec_mean = [];
N_vec_mean = [];
L_vec_mean = [];
num_input_vec_mean = [];
num_hidden_vec_mean = [];
num_output_vec_mean = [];
msre_train_mean = [];
msre_val_mean = [];
msre_test_mean = [];
epoch_vec_mean = [];
time_train_vec_mean = [];
time_feat_vec_mean = [];

for i=1:6
    frame_length = frame_length*i;
    fprintf('%d value of frame length', frame_lrngth);
    for j = 1:20
        fprintf('%d iteration \n', j);
        tic
        [sound_train, final_output] = main(frame_length, frame_shift, alpha, window, R, M, N, L);
        time_feat = toc;

        tic
        [net, tr] = nnet_simple(sound_train, final_output);
        time_train = toc;

        epochs = tr.epoch(end);
        msret = tr.perf(end);
        msrev = tr.vperf(end);
        msretest = tr.tperf(end);

        Iw = cell2mat(net.IW);
        Lw = cell2mat(net.LW);
        b1  = cell2mat(net.b(1));
        b2 = cell2mat(net.b(2));

        num_input = size(Iw, 2);
        num_hidden = size(Iw, 1);
        num_output = size(Lw, 1);

        frame_len_vec = [frame_len_vec; frame_length];
        frame_shift_vec = [frame_shift_vec; frame_shift];
        alpha_vec = [alpha_vec; alpha];
        M_vec = [M_vec; M];
        N_vec = [N_vec; N];
        L_vec = [L_vec; L];

        num_input_vec = [num_input_vec; num_input];
        num_hidden_vec = [num_hidden_vec; num_hidden];
        num_output_vec = [num_output_vec; num_output];

        msre_train = [msre_train; msret];
        msre_val = [msre_val; msrev];
        msre_test = [msre_test; msretest];

        epoch_vec = [epoch_vec; epochs];
        time_feat_vec = [time_feat_vec; time_feat];
        time_train_vec = [time_train_vec; time_train];
    end
    
end

















