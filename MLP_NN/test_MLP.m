%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multilayer Perceptron (MLP) Neural Network Function using MATLAB:       %
%  An implementation for Multilayer Perceptron Feed Forward Fully         %
%  Connected Neural Network with a sigmoid activation function. The       %
%  training is done using the Backpropagation algorithm with options for  %
%  Resilient Gradient Descent, Momentum Backpropagation, and Learning     %
%  Rate Decrease. The training stops when the Mean Square Error (MSE)     %
%  reaches zero or a predefined maximum number of epochs is reached.      %
%                                                                         %
%  Four example data for training and testing are included with the       %
%  project. They are generated by SharkTime Sharky Neural Network         %
%   (http://sharktime.com/us_SharkyNeuralNetwork.html)                    %
%                                                                         %
% Copyright (C) 9-2015 Hesham M. Eraqi. All rights reserved.              %
%                    hesham.eraqi@gmail.com                               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear Variables, Close Current Figures, and Create Results Directory 
clc;
clear all;
close all;
mkdir('Results//'); %Directory for Storing Results

%% Configurations/Parameters
dataFileName = 'sound.random.points'; %sharky.linear.points - sharky.circle.points - sharky.wave.points - sharky.spirals.points
nbrOfNeuronsInEachHiddenLayer = [10 10]; %linear:[4] - circle:[10] - wave,spirals:[10 10]
nbrOfOutUnits = 2;
unipolarBipolarSelector = 0; %0 for Unipolar, -1 for Bipolar

learningRate = 0.15;
nbrOfEpochs_max = 5000;

enable_resilient_gradient_descent = 1; %1 for enable, 0 for disable
learningRate_plus = 1.2;
learningRate_negative = 0.5;
deltas_start = 0.9;
deltas_min = 10^-6;
deltas_max = 50;

enable_decrease_learningRate = 0; %1 for enable decreasing, 0 for disable
learningRate_decreaseValue = 0.0001;
min_learningRate = 0.05;

enable_learningRate_momentum = 0; %1 for enable, 0 for disable
momentum_alpha = 0.05;

draw_each_nbrOfEpochs = 100;

%% Read Data
importedData = importdata(dataFileName, '\t', 6);
Samples = importedData.data(:, 1:length(importedData.data(1,:))-1);
TargetClasses = importedData.data(:, length(importedData.data(1,:)));
TargetClasses = TargetClasses - min(TargetClasses);
ActualClasses = -1*ones(size(TargetClasses));

%% Calculate Number of Input and Output NodesActivations
nbrOfInputNodes = length(Samples(1,:)); %=Dimention of Any Input Samples
% nbrOfOutUnits = ceil(log2(length(unique(TargetClasses)))) + !; %Ceil(Log2( Number of Classes ))

nbrOfLayers = 2 + length(nbrOfNeuronsInEachHiddenLayer);
nbrOfNodesPerLayer = [nbrOfInputNodes nbrOfNeuronsInEachHiddenLayer nbrOfOutUnits];

%% Adding the Bias as Nodes with a fixed Activation of 1
nbrOfNodesPerLayer(1:end-1) = nbrOfNodesPerLayer(1:end-1) + 1;
Samples = [ones(length(Samples(:,1)),1) Samples];

%% Calculate TargetOutputs %TODO needs to be general for any nbrOfOutUnits
TargetOutputs = zeros(length(TargetClasses), nbrOfOutUnits);
for i=1:length(TargetClasses)
    if (TargetClasses(i) == 1)
        TargetOutputs(i,:) = [1 unipolarBipolarSelector];
    else
        TargetOutputs(i,:) = [unipolarBipolarSelector 1];
    end
end

%% Initialize Random Wieghts Matrices
Weights = cell(1, nbrOfLayers); %Weights connecting bias nodes with previous layer are useless, but to make code simpler and faster
Delta_Weights = cell(1, nbrOfLayers);
ResilientDeltas = Delta_Weights; % Needed in case that Resilient Gradient Descent is used
for i = 1:length(Weights)-1
    Weights{i} = 2*rand(nbrOfNodesPerLayer(i), nbrOfNodesPerLayer(i+1))-1; %RowIndex: From Node Number, ColumnIndex: To Node Number
    Weights{i}(:,1) = 0; %Bias nodes weights with previous layer (Redundant step)
    Delta_Weights{i} = zeros(nbrOfNodesPerLayer(i), nbrOfNodesPerLayer(i+1));
    ResilientDeltas{i} = deltas_start*ones(nbrOfNodesPerLayer(i), nbrOfNodesPerLayer(i+1));
end
Weights{end} = ones(nbrOfNodesPerLayer(end), 1); %Virtual Weights for Output Nodes
Old_Delta_Weights_for_Momentum = Delta_Weights;
Old_Delta_Weights_for_Resilient = Delta_Weights;

NodesActivations = cell(1, nbrOfLayers);
for i = 1:length(NodesActivations)
    NodesActivations{i} = zeros(1, nbrOfNodesPerLayer(i));
end
NodesBackPropagatedErrors = NodesActivations; %Needed for Backpropagation Training Backward Pass

zeroRMSReached = 0;
nbrOfEpochs_done = 0;

%% Iterating all the Data
MSE = -1 * ones(1,nbrOfEpochs_max);
for Epoch = 1:nbrOfEpochs_max
    
    for Sample = 1:length(Samples(:,1))
        %% Backpropagation Training
        %Forward Pass
        NodesActivations{1} = Samples(Sample,:);
        for Layer = 2:nbrOfLayers
            NodesActivations{Layer} = NodesActivations{Layer-1}*Weights{Layer-1};
            NodesActivations{Layer} = Activation_func(NodesActivations{Layer}, unipolarBipolarSelector);
            if (Layer ~= nbrOfLayers) %Because bias nodes don't have weights connected to previous layer
                NodesActivations{Layer}(1) = 1;
            end
        end
        
        % Backward Pass Errors Storage
        % (As gradient of the bias nodes are zeros, they won't contribute to previous layer errors nor delta_weights)
        NodesBackPropagatedErrors{nbrOfLayers} =  TargetOutputs(Sample,:)-NodesActivations{nbrOfLayers};
        for Layer = nbrOfLayers-1:-1:1
            gradient = Activation_func_drev(NodesActivations{Layer+1}, unipolarBipolarSelector);
            for node=1:length(NodesBackPropagatedErrors{Layer}) % For all the Nodes in current Layer
                NodesBackPropagatedErrors{Layer}(node) =  sum( NodesBackPropagatedErrors{Layer+1} .* gradient .* Weights{Layer}(node,:) );
            end
        end
        
        % Backward Pass Delta Weights Calculation (Before multiplying by learningRate)
        for Layer = nbrOfLayers:-1:2
            derivative = Activation_func_drev(NodesActivations{Layer}, unipolarBipolarSelector);    
            Delta_Weights{Layer-1} = Delta_Weights{Layer-1} + NodesActivations{Layer-1}' * (NodesBackPropagatedErrors{Layer} .* derivative);
        end
    end
    
    %% Apply resilient gradient descent or/and momentum to the delta_weights
    if (enable_resilient_gradient_descent) % Handle Resilient Gradient Descent
        if (mod(Epoch,200)==0) %Reset Deltas
            for Layer = 1:nbrOfLayers
                ResilientDeltas{Layer} = learningRate*Delta_Weights{Layer};
            end
        end
        for Layer = 1:nbrOfLayers-1
            mult = Old_Delta_Weights_for_Resilient{Layer} .* Delta_Weights{Layer};
            ResilientDeltas{Layer}(mult > 0) = ResilientDeltas{Layer}(mult > 0) * learningRate_plus; % Sign didn't change
            ResilientDeltas{Layer}(mult < 0) = ResilientDeltas{Layer}(mult < 0) * learningRate_negative; % Sign changed
            ResilientDeltas{Layer} = max(deltas_min, ResilientDeltas{Layer});
            ResilientDeltas{Layer} = min(deltas_max, ResilientDeltas{Layer});

            Old_Delta_Weights_for_Resilient{Layer} = Delta_Weights{Layer};

            Delta_Weights{Layer} = sign(Delta_Weights{Layer}) .* ResilientDeltas{Layer};
        end
    end
    if (enable_learningRate_momentum) %Apply Momentum
        for Layer = 1:nbrOfLayers
            Delta_Weights{Layer} = learningRate*Delta_Weights{Layer} + momentum_alpha*Old_Delta_Weights_for_Momentum{Layer}; 
        end
        Old_Delta_Weights_for_Momentum = Delta_Weights;
    end
    if (~enable_learningRate_momentum && ~enable_resilient_gradient_descent)
        for Layer = 1:nbrOfLayers
            Delta_Weights{Layer} = learningRate * Delta_Weights{Layer};
        end
    end

    %% Backward Pass Weights Update
    for Layer = 1:nbrOfLayers-1
        Weights{Layer} = Weights{Layer} + Delta_Weights{Layer};
    end
    
    % Resetting Delta_Weights to Zeros
    for Layer = 1:length(Delta_Weights)
        Delta_Weights{Layer} = 0 * Delta_Weights{Layer};
    end

    %% Decrease Learning Rate
    if (enable_decrease_learningRate)
        new_learningRate = learningRate - learningRate_decreaseValue;
        learningRate = max(min_learningRate, new_learningRate);
    end
    
    %% Evaluation
    for Sample = 1:length(Samples(:,1))
        outputs = EvaluateNetwork(Samples(Sample,:), NodesActivations, Weights, unipolarBipolarSelector);
        bound = (1+unipolarBipolarSelector)/2;
        if (outputs(1) >= bound && outputs(2) < bound) %TODO: Not generic role for any number of output nodes
            ActualClasses(Sample) = 1;
        elseif (outputs(1) < bound && outputs(2) >= bound)
            ActualClasses(Sample) = 0;
        else
            if (outputs(1) >= outputs(2))
                ActualClasses(Sample) = 1;
            else
                ActualClasses(Sample) = 0;
            end
        end
    end
    
    MSE(Epoch) = sum((ActualClasses-TargetClasses).^2)/(length(Samples(:,1)));
    if (MSE(Epoch) == 0)
        zeroRMSReached = 1;
    end
        
    %% Visualization
    
    display([int2str(Epoch) ' Epochs done out of ' int2str(nbrOfEpochs_max) ' Epochs. MSE = ' num2str(MSE(Epoch)) ' Learning Rate = ' ...
        num2str(learningRate) '.']);
    
    nbrOfEpochs_done = Epoch;
    
end
display(['Mean Square Error = ' num2str(MSE(nbrOfEpochs_done)) '.']);
