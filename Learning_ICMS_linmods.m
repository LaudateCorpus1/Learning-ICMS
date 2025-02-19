%% Fitting Setup
clear; close all

% Load Test Data
load('Learning_ICMS_SNR_models.mat')
data               = NEmeansC;
SEdat              = NEstdsC;
meanData           = mean(data);
data               = data - meanData;

% Initial values for all parameters for each run
InitCondAll{1}     = mean(data);
InitCondAll{2}     = [0 mean([data(2) data(3)])];
InitCondAll{3}     = [0 mean([data(1) data(3)])]; 
InitCondAll{4}     = [0 mean([data(2) data(3)])]; 

% Free Parameters for each run
SelectParamsAll{1} = 1;
SelectParamsAll{2} = [1 2];
SelectParamsAll{3} = [1 2];
SelectParamsAll{4} = [1 2];

% Info4FitFun Supplies information to fitting function
Info4FitFun.data   = data;
Info4FitFun.ndat   = ndatNEC;
Info4FitFun.SEtype = 1;     % 1 = known SE & 0 = unknown SE
Info4FitFun.SEdat  = SEdat; % if .SEtype = 1, then user provides SE

% Pointer to script containing models for comparison
NameFun = @Learning_ICMS_linmodsfun;
nIter   = 4;     % Number of models to be evaluated

%% Run Fitting Procedure
disp('Start the run')
for ii=1:nIter,
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Specify Model for this iteration %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Info4FitFun.nIter = ii;  %The number of different models to iterate over
    
    SelectParams = SelectParamsAll{ii}; %which of the params should float
    
    %starting values for complete set of floating and fixed parameters
    InitCond     = InitCondAll{ii};
    disp(' ')    %for skipping a line on output
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Run Linear Analysis of a given model with set floating and fixed parameters %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp(['* * *  This is run ' num2str(ii) ' and float params ' num2str(SelectParams) ' * * * * * *'])
    %* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
    
    %call the script that does the nonlinear regression and further analyses
    outAll{ii} = GenericLSQ_JL(NameFun, SelectParams,InitCond,Info4FitFun);
    %* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
end

%% F-Tests
F12     = (outAll{1}.chisqLSQ - outAll{2}.chisqLSQ)/outAll{2}.chisqLSQ;
probF12 = 1 - fcdf(F12,1,ndatSig - outAll{2}.DegFreedom);

F13     = (outAll{1}.chisqLSQ - outAll{3}.chisqLSQ)/outAll{3}.chisqLSQ;
probF13 = 1 - fcdf(F13,1,ndatSig - outAll{3}.DegFreedom);

F14     = (outAll{1}.chisqLSQ - outAll{4}.chisqLSQ)/outAll{4}.chisqLSQ;
probF14 = 1 - fcdf(F14,1,ndatSig - outAll{4}.DegFreedom);

disp('F12    F13    F14')
[F12 F13 F14]

disp('ProbF12    ProbF13     ProbF14')
[probF12 probF13 probF14]

%% Plot
scrnsz  = get(0,'Screensize');
figure('Position',scrnsz)
for n = 1:4
    subplot(2,2,n),plot(data,'linewidth',2),hold on,plot(outAll{n}.expect,'r','linewidth',2),axis square
    title(['Model ' num2str(n)])
end
