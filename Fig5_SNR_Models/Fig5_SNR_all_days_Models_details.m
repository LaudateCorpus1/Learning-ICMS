% Examining SNR models across all days for each subject

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Generating SNR models for each subject, each day, in the test hemisphere %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% basic parameters
bin       = 10;
win       = 500;
ind       = win/bin;

%%%%%%%
% R29 %
%%%%%%%
disp('R29_test')
cd('C:\Data\Plexon_Data\Test_Data\Learning\R29')
[file_list1] = find_files('R29','17_32');

% Generate SNR signal and internal noise models
for n = 1:length(file_list1)
    % Let's grab the file date
    file  = file_list1{n};
    [temp,name] = fileparts(file);
    parse = findstr(name,'_');
    date  = name(parse(1)+1:parse(2)-1);
    
    % Generate PSTHs for each unit reference to ICMS
    [all_psth,ave_fr,unitIds,event_time] = units_all_PSTH(file,'Event015',bin,win,win);
    eval(['R29_ICMS_psth_' date ' = all_psth;'])
    
    %%%%%%%%%%%%%%%%%%%
    %%% SNR Metrics %%%
    %%%%%%%%%%%%%%%%%%%
    data    = all_psth;
    
    % Determine size of variable and allocate memory
    temp    = size(data,2);
    
    % Calculate SNR signal model
    sig_mod = zeros(temp,1);
    
    % Calculate SNR internal noise model
    nois_mod = zeros(temp,1);
    
    for p = 1:temp
        pre        = data(1:ind,p);
        post       = data(ind+1:end,p);
        
        % Calculate increase in signal relative to background (z-score)
        sig_mod(p) = (max(post) - mean(pre))/std(pre);
        
        % Calculate internal noise metric 
        meanb = mean(pre);
        
        % Generate baseline bin values below baseline average firing rate
        base  = meanb - pre;
        base  = base(base > 0);
        
        % Generate test bins values below baseline average firing rate
        test  = meanb - post;
        test  = test(test > 0);
        
        % Calculate increase in signal relative to background (t-test, unequal
        % samples and unequal variances)
        nois_mod(p) = (mean(test)-mean(base))/...
                      (sqrt(var(test)/length(test) + var(base)/length(base)));
        
    end

    eval(['R29_ICMS_psth_' date '_SNRs  = sig_mod;'])
    eval(['R29_ICMS_psth_' date '_SNRb  = nois_mod;'])
    
end

close all

%%%%%%%
% V1 %
%%%%%%%
disp('V1_test')
cd('C:\Data\Plexon_Data\Test_Data\Learning\V1')
[file_list2] = find_files('V1','1_16');

for n = 1:length(file_list2)
    % Let's grab the file date
    file  = file_list2{n};
    [temp,name] = fileparts(file);
    parse = findstr(name,'_');
    date  = name(parse(1)+1:parse(2)-1);
    
    % Generate PSTHs for each unit reference to ICMS
    [all_psth,ave_fr,unitIds,event_time] = units_all_PSTH(file,'Event015',bin,win,win);
    eval(['V1_ICMS_psth_' date ' = all_psth;'])
    
    %%%%%%%%%%%%%%%%%%%
    %%% SNR Metrics %%%
    %%%%%%%%%%%%%%%%%%%
    data    = all_psth;
    
    % Determine size of variable and allocate memory
    temp    = size(data,2);
    
    % Calculate SNR signal model
    sig_mod = zeros(temp,1);
    
    % Calculate SNR internal noise model
    nois_mod = zeros(temp,1);
    
    for p = 1:temp
        pre        = data(1:ind,p);
        post       = data(ind+1:end,p);
        
        % Calculate increase in signal relative to background (z-score)
        sig_mod(p) = (max(post) - mean(pre))/std(pre);
        
        % Calculate internal noise metric 
        meanb = mean(pre);
        
        % Generate baseline bin values below baseline average firing rate
        base  = meanb - pre;
        base  = base(base > 0);
        
        % Generate test bins values below baseline average firing rate
        test  = meanb - post;
        test  = test(test > 0);
        
        % Calculate increase in signal relative to background (t-test, unequal
        % samples and unequal variances)
        nois_mod(p) = (mean(test)-mean(base))/...
                      (sqrt(var(test)/length(test) + var(base)/length(base)));
        
    end

    eval(['V1_ICMS_psth_' date '_SNRs  = sig_mod;'])
    eval(['V1_ICMS_psth_' date '_SNRb  = nois_mod;'])
    
end

close all

%%%%%%%
% V4 %
%%%%%%%
disp('V4_test')
cd('C:\Data\Plexon_Data\Test_Data\Learning\V4')
[file_list3] = find_files('V4','1_16');

for n = 1:length(file_list3)
    % Let's grab the file date
    file  = file_list3{n};
    [temp,name] = fileparts(file);
    parse = findstr(name,'_');
    date  = name(parse(1)+1:parse(2)-1);
    
    % Generate PSTHs for each unit reference to ICMS
    [all_psth,ave_fr,unitIds,event_time] = units_all_PSTH(file,'Event015',bin,win,win);
    eval(['V4_ICMS_psth_' date ' = all_psth;'])
    
    %%%%%%%%%%%%%%%%%%%
    %%% SNR Metrics %%%
    %%%%%%%%%%%%%%%%%%%
    data    = all_psth;
    
    % Determine size of variable and allocate memory
    temp    = size(data,2);
    
    % Calculate SNR signal model
    sig_mod = zeros(temp,1);
    
    % Calculate SNR internal noise model
    nois_mod = zeros(temp,1);
    
    for p = 1:temp
        pre        = data(1:ind,p);
        post       = data(ind+1:end,p);
        
        % Calculate increase in signal relative to background (z-score)
        sig_mod(p) = (max(post) - mean(pre))/std(pre);
        
        % Calculate internal noise metric 
        meanb = mean(pre);
        
        % Generate baseline bin values below baseline average firing rate
        base  = meanb - pre;
        base  = base(base > 0);
        
        % Generate test bins values below baseline average firing rate
        test  = meanb - post;
        test  = test(test > 0);
        
        % Calculate increase in signal relative to background (t-test, unequal
        % samples and unequal variances)
        nois_mod(p) = (mean(test)-mean(base))/...
                      (sqrt(var(test)/length(test) + var(base)/length(base)));
        
    end

    eval(['V4_ICMS_psth_' date '_SNRs  = sig_mod;'])
    eval(['V4_ICMS_psth_' date '_SNRb  = nois_mod;'])
    
end

close all

%%%%%%%
% V7 %
%%%%%%%
disp('V7_test')
cd('C:\Data\Plexon_Data\Test_Data\Learning\V7')
[file_list4] = find_files('V7','1_16');

for n = 1:length(file_list4)
    % Let's grab the file date
    file  = file_list4{n};
    [temp,name] = fileparts(file);
    parse = findstr(name,'_');
    date  = name(parse(1)+1:parse(2)-1);
    
    % Generate PSTHs for each unit reference to ICMS
    [all_psth,ave_fr,unitIds,event_time] = units_all_PSTH(file,'Event015',bin,win,win);
    eval(['V7_ICMS_psth_' date ' = all_psth;'])
    
    %%%%%%%%%%%%%%%%%%%
    %%% SNR Metrics %%%
    %%%%%%%%%%%%%%%%%%%
    data    = all_psth;
    
    % Determine size of variable and allocate memory
    temp    = size(data,2);
    
    % Calculate SNR signal model
    sig_mod = zeros(temp,1);
    
    % Calculate SNR internal noise model
    nois_mod = zeros(temp,1);
    
    for p = 1:temp
        pre        = data(1:ind,p);
        post       = data(ind+1:end,p);
        
        % Calculate increase in signal relative to background (z-score)
        sig_mod(p) = (max(post) - mean(pre))/std(pre);
        
        % Calculate internal noise metric 
        meanb = mean(pre);
        
        % Generate baseline bin values below baseline average firing rate
        base  = meanb - pre;
        base  = base(base > 0);
        
        % Generate test bins values below baseline average firing rate
        test  = meanb - post;
        test  = test(test > 0);
        
        % Calculate increase in signal relative to background (t-test, unequal
        % samples and unequal variances)
        nois_mod(p) = (mean(test)-mean(base))/...
                      (sqrt(var(test)/length(test) + var(base)/length(base)));
        
    end

    eval(['V7_ICMS_psth_' date '_SNRs  = sig_mod;'])
    eval(['V7_ICMS_psth_' date '_SNRb  = nois_mod;'])
    
end

close all

%%%%%%%
% V8 %
%%%%%%%
disp('V8_test')
cd('C:\Data\Plexon_Data\Test_Data\Learning\V8')
[file_list5] = find_files('V8','1_16');

for n = 1:length(file_list5)
    % Let's grab the file date
    file  = file_list5{n};
    [temp,name] = fileparts(file);
    parse = findstr(name,'_');
    date  = name(parse(1)+1:parse(2)-1);
    
    % Generate PSTHs for each unit reference to ICMS
    [all_psth,ave_fr,unitIds,event_time] = units_all_PSTH(file,'Event015',bin,win,win);
    eval(['V8_ICMS_psth_' date ' = all_psth;'])
    
    %%%%%%%%%%%%%%%%%%%
    %%% SNR Metrics %%%
    %%%%%%%%%%%%%%%%%%%
    data    = all_psth;
    
    % Determine size of variable and allocate memory
    temp    = size(data,2);
    
    % Calculate SNR signal model
    sig_mod = zeros(temp,1);
    
    % Calculate SNR internal noise model
    nois_mod = zeros(temp,1);
    
    for p = 1:temp
        pre        = data(1:ind,p);
        post       = data(ind+1:end,p);
        
        % Calculate increase in signal relative to background (z-score)
        sig_mod(p) = (max(post) - mean(pre))/std(pre);
        
        % Calculate internal noise metric 
        meanb = mean(pre);
        
        % Generate baseline bin values below baseline average firing rate
        base  = meanb - pre;
        base  = base(base > 0);
        
        % Generate test bins values below baseline average firing rate
        test  = meanb - post;
        test  = test(test > 0);
        
        % Calculate increase in signal relative to background (t-test, unequal
        % samples and unequal variances)
        nois_mod(p) = (mean(test)-mean(base))/...
                      (sqrt(var(test)/length(test) + var(base)/length(base)));
        
    end

    eval(['V8_ICMS_psth_' date '_SNRs  = sig_mod;'])
    eval(['V8_ICMS_psth_' date '_SNRb  = nois_mod;'])
    
end

close all

cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig5_SNR_Models')
save('Figure5_ICMS_PSTH_SNR_all_days_bin10_win500.mat','R29_*','V1_*','V4_*','V7_*','V8_*')
clear
