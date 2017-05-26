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
time_train = [];

for j = 1:100
    [net, mean_train, dev_train, epochs, msret, ...
        msrev, msretest, time, num_input, num_hidden, num_output]...
                        = train_one_time();
    
    j
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
    time_train = [time_train; time];
end

xlswrite('SamplingData1.xlsx', frame_len_vec, 'Sheet1', 'A2:A101');
xlswrite('SamplingData1.xlsx', frame_shift_vec, 'Sheet1','B2:B101');
xlswrite('SamplingData1.xlsx', alpha_vec, 'Sheet1','C2:C101');
xlswrite('SamplingData1.xlsx', M_vec, 'Sheet1','D2:D101');
xlswrite('SamplingData1.xlsx', N_vec, 'Sheet1','E2:E101');
xlswrite('SamplingData1.xlsx', L_vec, 'Sheet1','F2:F101');
xlswrite('SamplingData1.xlsx', num_input_vec, 'Sheet1','G2:G101');
xlswrite('SamplingData1.xlsx', num_hidden_vec, 'Sheet1','H2:H101');
xlswrite('SamplingData1.xlsx', num_output_vec, 'Sheet1','I2:I101');


xlswrite('SamplingData1.xlsx', msre_train, 'Sheet1','J2:J101');
xlswrite('SamplingData1.xlsx', msre_val, 'Sheet1','K2:K101');
xlswrite('SamplingData1.xlsx', msre_test, 'Sheet1','L2:L101');
xlswrite('SamplingData1.xlsx', epoch_vec, 'Sheet1','M2:M101');
xlswrite('SamplingData1.xlsx', time_train, 'Sheet1','N2:N101');