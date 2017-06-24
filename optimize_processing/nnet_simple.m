% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by Neural Pattern Recognition app
% Created 26-May-2017 10:06:00
%
% This script assumes these variables are defined:
%
%   sound_train - input data.
%   final_output - target data.
function[net, tr, percentErrors, performance] = nnet_simple(sound_train, final_output, hidden_node)
x = sound_train';
t = final_output';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = hidden_node;
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

%load('trainIndFull.mat'); load('testIndFull.mat'); load('valIndFull.mat');
%load('trainIndFull.mat'); load('testIndFull.mat'); load('valIndFull.mat');
%net.divideFcn = 'divideind';
net.divideFcn = 'dividerand';

%net.divideParam.trainInd = trainInd;
%net.divideParam.valInd = valInd;
%net.divideParam.testInd = testInd;
%net.divideParam.trainInd = trainIndFull;
%net.divideParam.valInd = valIndFull;
%net.divideParam.testInd = testIndFull;

net.trainParam.lr = 0.0001;
%net.trainParam.showWindow = 0;
net.trainParam.min_grad = 1e-6;
%net.trainParam.goal = 0.001;
net.trainParam.max_fail = 6;

%load('seed.mat')
%rng(seed)
%rng(1234567)
net = configure(net,x,t);
% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = crossentropy(net,t,y);
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)
end

