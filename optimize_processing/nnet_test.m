% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by Neural Pattern Recognition app
% Created 25-Jun-2017 21:53:18
%
% This script assumes these variables are defined:
%
%   x - input data.
%   t - target data.
function[net, tr, percentErrors, performance] = nnet_test(x, t)

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 1;
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

net.divideFcn = 'dividerand';
net.trainParam.lr = 0.0001;
%net.trainParam.showWindow = 0;
net.trainParam.min_grad = 1e-6;
%net.trainParam.goal = 0.001;
net.trainParam.max_fail = 6;

%REMOVE THIS FOR MSEPERFORMFCN
%net.performFcn = 'crossentropy';
%net.performParam.regularization = 0.1;
%net.performParam.normalization = 'none';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

net = configure(net,x,t);
% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
%view(net)
end
% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)
