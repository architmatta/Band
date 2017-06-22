function[] = repeat_same_param(frame_length, frame_shift, alpha, window, R, M, N, L, sheet, hidden_node, TAG)

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
percent_test = [];
performance_test = [];
epoch_vec = [];
time_train_vec = [];
time_feat_vec = [];

fprintf('%d, %d, %d, %f', frame_length, frame_shift, N, hidden_node);

for j = 1:5
    fprintf('%d iteration in %s\n', j, TAG);
    tic
    [sound_train, final_output] = main(frame_length, frame_shift, alpha, window, R, M, N, L, TAG);
    time_feat = toc;
    hidden = floor(size(sound_train, 2)*hidden_node);
    tic
    [net, tr, percentError, performance] = nnet_simple(sound_train, final_output, hidden);
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
    percent_test = [percent_test; percentError];
    performance_test = [performance_test; performance];
    
    epoch_vec = [epoch_vec; epochs];
    time_feat_vec = [time_feat_vec; time_feat];
    time_train_vec = [time_train_vec; time_train];
end

xlswrite('FinalResultSheets.xlsx', frame_len_vec, sheet, strcat('A2:A', int2str(length(frame_len_vec)+1)));
xlswrite('FinalResultSheets.xlsx', frame_shift_vec, sheet,strcat('B2:B', int2str(length(frame_shift_vec)+1)));
xlswrite('FinalResultSheets.xlsx', alpha_vec, sheet,strcat('C2:C', int2str(length(alpha_vec)+1)));
xlswrite('FinalResultSheets.xlsx', M_vec, sheet,strcat('D2:D', int2str(length(M_vec)+1)));
xlswrite('FinalResultSheets.xlsx', N_vec, sheet,strcat('E2:E', int2str(length(N_vec)+1)));
xlswrite('FinalResultSheets.xlsx', L_vec, sheet,strcat('F2:F', int2str(length(L_vec)+1)));
xlswrite('FinalResultSheets.xlsx', num_input_vec, sheet,strcat('G2:G', int2str(length(num_input_vec)+1)));
xlswrite('FinalResultSheets.xlsx', num_hidden_vec, sheet,strcat('H2:H', int2str(length(num_hidden_vec)+1)));
xlswrite('FinalResultSheets.xlsx', num_output_vec, sheet,strcat('I2:I', int2str(length(num_output_vec)+1)));


xlswrite('FinalResultSheets.xlsx', msre_train, sheet,strcat('J2:J', int2str(length(msre_train)+1)));
xlswrite('FinalResultSheets.xlsx', msre_val, sheet,strcat('K2:K', int2str(length(msre_val)+1)));
xlswrite('FinalResultSheets.xlsx', msre_test, sheet,strcat('L2:L', int2str(length(msre_test)+1)));
xlswrite('FinalResultSheets.xlsx', epoch_vec, sheet,strcat('M2:M', int2str(length(epoch_vec)+1)));
xlswrite('FinalResultSheets.xlsx', time_feat_vec, sheet,strcat('N2:N', int2str(length(time_feat_vec)+1)));
xlswrite('FinalResultSheets.xlsx', time_train_vec, sheet,strcat('O2:O', int2str(length(time_train_vec)+1)));
xlswrite('FinalResultSheets.xlsx', percent_test, sheet,strcat('P2:P', int2str(length(percent_test)+1)));
xlswrite('FinalResultSheets.xlsx', performance_test, sheet,strcat('Q2:Q', int2str(length(performance_test)+1)));
%{
mean_frame_length = mean(frame_len_vec);
mean_frame_shift = mean(frame_shift_vec);
mean_alpha = mean(alpha_vec);
mean_M = mean(M_vec);
mean_N = mean(N_vec);
mean_L = mean(L_vec);

mean_input = mean(num_input_vec);
mean_hidden = mean(num_hidden_vec);
mean_output = mean(num_output_vec);

mean_msre_train = mean(msre_train);
mean_msre_val = mean(msre_val);
mean_msre_test = mean(msre_test);

mean_epoch = mean(epoch_vec);
mean_time_feat = mean(time_feat_vec);
mean_time_train = mean(time_train_vec);
%}

end