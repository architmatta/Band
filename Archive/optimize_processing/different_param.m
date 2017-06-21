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

set_frame_length = [150; 200; 250; 300; 350; 400; 450; 500]; %maximum could be 2875ms because 25 is frame_shift and not overlap

for i = 1:6
    frame_length = set_frame_length(i);
    sheet = strcat('FrameLength', int2str(i));
    fprintf('%d value of frame_length', i);
    
    [mean_frame_length, mean_frame_shift, mean_alpha, mean_M, mean_N,...
    mean_L, mean_input, mean_hidden, mean_output, mean_msre_train, ...
    mean_msre_val, mean_msre_test, mean_epoch, mean_time_feat, ...
    mean_time_train] ...
            = repeat_same_param(frame_length, frame_shift, alpha, window, R, M, N, L, sheet);

    frame_len_vec_mean = [frame_len_vec_mean; mean_frame_length];
    frame_shift_vec_mean = [frame_shift_vec_mean; mean_frame_shift];
    alpha_vec_mean = [alpha_vec_mean; mean_alpha];
    M_vec_mean = [M_vec_mean; mean_M];
    N_vec_mean = [N_vec_mean; mean_N];
    L_vec_mean = [L_vec_mean; mean_L];
    num_input_vec_mean = [num_input_vec_mean; mean_input];
    num_hidden_vec_mean = [num_hidden_vec_mean; mean_hidden];
    num_output_vec_mean = [num_output_vec_mean; mean_output];
    msre_train_mean = [msre_train_mean, mean_msre_train];
    msre_val_mean = [msre_val_mean; mean_msre_val];
    msre_test_mean = [msre_test_mean; mean_msre_test];
    epoch_vec_mean = [epoch_vec_mean; mean_epoch];
    time_train_vec_mean = [time_train_vec_mean; mean_time_feat];
    time_feat_vec_mean = [time_feat_vec_mean; mean_time_train];  
end

%RUN BELOW PART AFTER ALL FINISHES TO STORE THE LAST ROW, IT WAS NOT ADDED
%TO + 1 in length of vec
xlswrite('SamplingData2.xlsx', frame_len_vec_mean, 'DifferentFrameLength', strcat('A2:A', int2str(length(frame_len_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', frame_shift_vec_mean, 'DifferentFrameLength',strcat('B2:B', int2str(length(frame_shift_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', alpha_vec_mean, 'DifferentFrameLength',strcat('C2:C', int2str(length(alpha_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', M_vec_mean, 'DifferentFrameLength',strcat('D2:D', int2str(length(M_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', N_vec_mean, 'DifferentFrameLength',strcat('E2:E', int2str(length(N_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', L_vec_mean, 'DifferentFrameLength',strcat('F2:F', int2str(length(L_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', num_input_vec_mean, 'DifferentFrameLength',strcat('G2:G', int2str(length(num_input_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', num_hidden_vec_mean, 'DifferentFrameLength',strcat('H2:H', int2str(length(num_hidden_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', num_output_vec_mean, 'DifferentFrameLength',strcat('I2:I', int2str(length(num_output_vec_mean)+1)));


xlswrite('SamplingData2.xlsx', msre_train_mean, 'DifferentFrameLength',strcat('J2:J', int2str(length(msre_train_mean)+1)));
xlswrite('SamplingData2.xlsx', msre_val_mean, 'DifferentFrameLength',strcat('K2:K', int2str(length(msre_val_mean)+1)));
xlswrite('SamplingData2.xlsx', msre_test_mean, 'DifferentFrameLength',strcat('L2:L', int2str(length(msre_test_mean)+1)));
xlswrite('SamplingData2.xlsx', epoch_vec_mean, 'DifferentFrameLength',strcat('M2:M', int2str(length(epoch_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', time_train_vec_mean, 'DifferentFrameLength',strcat('N2:N', int2str(length(time_train_vec_mean)+1)));
xlswrite('SamplingData2.xlsx', time_feat_vec_mean, 'DifferentFrameLength',strcat('O2:O', int2str(length(time_feat_vec_mean)+1)));


