%%% Purpose: To bootstrap error bars on previously calculated SNR metrics for
%%% signal and internal noise
cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig5_SNR_Models')
load('Figure5_ICMS_PSTH_SNR_all_days_bin10_win500.mat')

%%%%%%%%%%%
%%% R29 %%%
%%%%%%%%%%%
R29s = who('-regexp','\<R29\w*SNRs\>');

% Determine minimum number of units for subject
R29_N   = 12;
bs_N    = 500;
bs_mean = zeros(bs_N,length(R29s));

for p = 1:length(R29s)
    
    eval(['data = ' R29s{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),R29_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

R29_means = nanmean(bs_mean);
R29_SEs   = nanstd(bs_mean);

R29b = who('-regexp','\<R29\w*SNRb\>');

% Reset values
bs_mean = zeros(bs_N,length(R29b));

for p = 1:length(R29b)
    
    eval(['data = ' R29b{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),R29_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

R29_meanb = nanmean(bs_mean);
R29_SEb   = nanstd(bs_mean);

%%%%%%%%%%
%%% V1 %%%
%%%%%%%%%%
V1s = who('-regexp','\<V1\w*SNRs\>');

% Determine minimum number of units for subject
V1_N   = 11;
bs_N    = 500;
bs_mean = zeros(bs_N,length(V1s));

for p = 1:length(V1s)
    
    eval(['data = ' V1s{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V1_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V1_means = nanmean(bs_mean);
V1_SEs   = nanstd(bs_mean);

V1b = who('-regexp','\<V1\w*SNRb\>');

bs_mean = zeros(bs_N,length(V1b));

for p = 1:length(V1b)
    
    eval(['data = ' V1b{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V1_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V1_meanb = nanmean(bs_mean);
V1_SEb   = nanstd(bs_mean);

V4s = who('-regexp','\<V4\w*SNRs\>');

% Determine minimum number of units for subject
V4_N   = 12;
bs_N    = 500;
bs_mean = zeros(bs_N,length(V4s));

for p = 1:length(V4s)
    
    eval(['data = ' V4s{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V4_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V4_means = nanmean(bs_mean);
V4_SEs   = nanstd(bs_mean);

V4b = who('-regexp','\<V4\w*SNRb\>');

bs_mean = zeros(bs_N,length(V4b));

for p = 1:length(V4b)
    
    eval(['data = ' V4b{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V4_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V4_meanb = nanmean(bs_mean);
V4_SEb   = nanstd(bs_mean);

V7s = who('-regexp','\<V7\w*SNRs\>');

% Determine minimum number of units for subject
V7_N   = 12;
bs_N    = 500;
bs_mean = zeros(bs_N,length(V7s));

for p = 1:length(V7s)
    
    eval(['data = ' V7s{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V7_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V7_means = nanmean(bs_mean);
V7_SEs   = nanstd(bs_mean);

V7b = who('-regexp','\<V7\w*SNRb\>');

bs_mean = zeros(bs_N,length(V7b));

for p = 1:length(V7b)
    
    eval(['data = ' V7b{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V7_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V7_meanb = nanmean(bs_mean);
V7_SEb   = nanstd(bs_mean);

V8s = who('-regexp','\<V8\w*SNRs\>');

% Determine minimum number of units for subject
V8_N   = 13;
bs_N    = 500;
bs_mean = zeros(bs_N,length(V8s));

for p = 1:length(V8s)
    
    eval(['data = ' V8s{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V8_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V8_means = nanmean(bs_mean);
V8_SEs   = nanstd(bs_mean);

V8b = who('-regexp','\<V8\w*SNRb\>');
bs_mean = zeros(bs_N,length(V8b));

for p = 1:length(V8b)
    
    eval(['data = ' V8b{p} ';']);
    
    for q = 1:bs_N
        rs         = randsample(length(data),V8_N,'true');
    
        bs_mean(q,p) = nanmean(data(rs));
    
    end
    
end

V8_meanb = nanmean(bs_mean);
V8_SEb   = nanstd(bs_mean);
