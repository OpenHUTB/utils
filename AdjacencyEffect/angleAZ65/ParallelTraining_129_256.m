% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by NFTOOL
% Created Thu Dec 31 11:23:09 CST 2015
%
% This script assumes these variables are defined:
%
%   input - input data.
%   output - target data.

%%
clc
clear

%%
cd Input
load input.txt
cd ..


%%
cd Output_1024x1024
width = 1024;
N = width*width;
tic

for i = 198: 256
    for j = 1 : 1024
        filename = [num2str(i) '_' num2str(j) '.txt'];
        output = load(filename);
        disp(i);
        disp(j);
        inputs = input';
        targets = output';
        
        % Create a Fitting Network
        hiddenLayerSize = 9;
        net = fitnet(hiddenLayerSize);

        % Setup Division of Data for Training, Validation, Testing
        net.divideParam.trainRatio = 70/100;
        net.divideParam.valRatio = 15/100;
        net.divideParam.testRatio = 15/100;

        % Train the Network
        [net,tr] = train(net,inputs,targets,'showResources','yes');

        % save training result
        cd ..
        cd TrainingResult
        netName = ['net_' num2str(i) '_' num2str(j)];
        save(netName, 'net');
        cd ..
        cd Output_1024x1024
    end
end

toc
cd ..
% Elapsed time is 21990.178173 seconds.


%%
% cd Output
% % files = dir('*.txt');
% N = 512;

% tic
% for i = 1 : N
%     filename = [num2str(i) '.txt'];
%     output = load (filename);
%     
%     inputs = input';
%     targets = output';
%     
%     % Create a Fitting Network
%     hiddenLayerSize = 10;
%     net = fitnet(hiddenLayerSize);
% 
% 
%     % Setup Division of Data for Training, Validation, Testing
%     net.divideParam.trainRatio = 70/100;
%     net.divideParam.valRatio = 15/100;
%     net.divideParam.testRatio = 15/100;
% 
%     % Train the Network
%     [net,tr] = train(net,inputs,targets, 'useParallel', 'yes','showResources','yes');
%     
%     % save training result
%     cd ..
%     cd TrainingResult
%     netName = ['net_' num2str(i)];
%     save(netName, 'net');
%     cd ..
%     cd Output
% 
% end

% toc
% cd ..

%%
% inputs = input';
% targets = output';

% Create a Fitting Network
% hiddenLayerSize = 10;
% net = fitnet(hiddenLayerSize);


% Setup Division of Data for Training, Validation, Testing
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;


% Train the Network
% [net,tr] = train(net,inputs,targets);

% Test the Network
% outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs)

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotfit(net,inputs,targets)
%figure, plotregression(targets,outputs)
%figure, ploterrhist(errors)
