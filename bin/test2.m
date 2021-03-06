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

sheet = 'SameVal5Parallel2';

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


for j = 1:30
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

xlswrite('SamplingData3.xlsx', frame_len_vec, sheet, strcat('A2:A', int2str(length(frame_len_vec)+1)));
xlswrite('SamplingData3.xlsx', frame_shift_vec, sheet,strcat('B2:B', int2str(length(frame_shift_vec)+1)));
xlswrite('SamplingData3.xlsx', alpha_vec, sheet,strcat('C2:C', int2str(length(alpha_vec)+1)));
xlswrite('SamplingData3.xlsx', M_vec, sheet,strcat('D2:D', int2str(length(M_vec)+1)));
xlswrite('SamplingData3.xlsx', N_vec, sheet,strcat('E2:E', int2str(length(N_vec)+1)));
xlswrite('SamplingData3.xlsx', L_vec, sheet,strcat('F2:F', int2str(length(L_vec)+1)));
xlswrite('SamplingData3.xlsx', num_input_vec, sheet,strcat('G2:G', int2str(length(num_input_vec)+1)));
xlswrite('SamplingData3.xlsx', num_hidden_vec, sheet,strcat('H2:H', int2str(length(num_hidden_vec)+1)));
xlswrite('SamplingData3.xlsx', num_output_vec, sheet,strcat('I2:I', int2str(length(num_output_vec)+1)));


xlswrite('SamplingData3.xlsx', msre_train, sheet,strcat('J2:J', int2str(length(msre_train)+1)));
xlswrite('SamplingData3.xlsx', msre_val, sheet,strcat('K2:K', int2str(length(msre_val)+1)));
xlswrite('SamplingData3.xlsx', msre_test, sheet,strcat('L2:L', int2str(length(msre_test)+1)));
xlswrite('SamplingData3.xlsx', epoch_vec, sheet,strcat('M2:M', int2str(length(epoch_vec)+1)));
xlswrite('SamplingData3.xlsx', time_feat_vec, sheet,strcat('N2:N', int2str(length(time_feat_vec)+1)));
xlswrite('SamplingData3.xlsx', time_train_vec, sheet,strcat('O2:O', int2str(length(time_train_vec)+1)));