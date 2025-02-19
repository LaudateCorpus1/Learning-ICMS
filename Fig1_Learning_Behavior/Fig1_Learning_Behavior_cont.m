% Fig 2 cont.
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Grab Stage 0 behavioral data %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd('C:\Data\Plexon_Data\Test_Data\R29\R29 Spikes & Events')
load('R29_050408_Events.mat')

event = structpack(who('Eve*'));
clear Eve*

[event] = Behavior_preproc(event);
structunpack(event)

% Initialize behavioral quantities of interest for evaluating test trials
% and then infer training trials information
Behavior    = zeros(3, length(Event011train));

for n = 1:length(Event011train)
    suc  = find(Event012 > Event011train(n),1,'first');
    fa   = find(Event013 > Event011train(n),1,'first');
    miss = find(Event014 > Event011train(n),1,'first');
    
    % Check for empty variables and grab appropriate timestamps
    if isempty(suc)
        suc_ck = inf;
    else
        suc_ck = Event012(suc);
    end
    
    if isempty(fa)
        fa_ck = inf;
    else
        fa_ck = Event013(fa);
    end
    
    if isempty(miss)
        miss_ck = inf;
    else
        miss_ck = Event014(miss);
    end
    
    [val,ind] = min([suc_ck fa_ck miss_ck]);
    
    % Update Behavior matrix
    if n == 1
        Behavior(ind,n) = 1;
    else
        Behavior(:,n)   = Behavior(:,n-1);
        Behavior(ind,n) = Behavior(ind,n-1) + 1;
    end
end

beh_sum1 = 100.*Behavior(:,end)./sum(Behavior(:,end));

keep beh_sum1

load('R29_050508_Events.mat')

event = structpack(who('Eve*'));
clear Eve*

[event] = Behavior_preproc(event);
structunpack(event)

% Initialize behavioral quantities of interest for evaluating tone trials
Behavior    = zeros(3, length(Event011train));

for n = 1:length(Event011train)
    suc  = find(Event012 > Event011train(n),1,'first');
    fa   = find(Event013 > Event011train(n),1,'first');
    miss = find(Event014 > Event011train(n),1,'first');
    
    % Check for empty variables and grab appropriate timestamps
    if isempty(suc)
        suc_ck = inf;
    else
        suc_ck = Event012(suc);
    end
    
    if isempty(fa)
        fa_ck = inf;
    else
        fa_ck = Event013(fa);
    end
    
    if isempty(miss)
        miss_ck = inf;
    else
        miss_ck = Event014(miss);
    end
    
    [val,ind] = min([suc_ck fa_ck miss_ck]);
    
    % Update Behavior matrix
    if n == 1
        Behavior(ind,n) = 1;
    else
        Behavior(:,n)   = Behavior(:,n-1);
        Behavior(ind,n) = Behavior(ind,n-1) + 1;
    end
end

beh_sum2 = 100.*Behavior(:,end)./sum(Behavior(:,end));

keep beh_sum1 beh_sum2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Grab Stage 1-3 behavioral data %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd('C:\Data\Plexon_Data\Test_Data\Learning\Tracking_KLs_test\R29')
[file_list] = find_files('R29','17_32_justICMS');
N           = length(file_list);

for n = 1:N
    load(file_list{n})
    eval(['Behavior' num2str(n) ' = Behavior;'])
    eval(['behavior_ts' num2str(n) ' = behavior_ts;'])
end

beh_sum      = zeros(3,N+2);
% Add in stage 0 data
beh_sum(:,1) = beh_sum1;
beh_sum(:,2) = beh_sum2;

for n = 1:N
    % Grab current variables
    eval(['Behavior    = Behavior' num2str(n) ';'])
    eval(['behavior_ts = behavior_ts' num2str(n) ';'])

    %Calculate percentages
    bsums        = sum(diff(Behavior,[],2),2);
    total        = sum(bsums);

    beh_sum(:,n+2) = 100.*bsums./total;
end


dpi   = 96;
figure('units','pixels','Position',[1 1 8.5*dpi 11*dpi])
pos   = [1*dpi 4*dpi 2.5*dpi 2*dpi];

% Plot Axes
axes('units','pixels','position',pos(1,:)),
plot(beh_sum(3,:),'vr','markerfacecolor','r','markersize',6),hold on,
plot(beh_sum(2,:),'sg','markerfacecolor','g','markersize',6)
plot(beh_sum(1,:),'ob','markerfacecolor','b','markersize',6)
plot(beh_sum(3,:),'r','linewidth',2.5)
plot(beh_sum(2,:),'g','linewidth',2.5)
plot(beh_sum(1,:),'b','linewidth',2.5)

ylim([0 100])
xlim([0.9 size(beh_sum,2)+0.1])
xlabel('Session #','fontsize',12,'fontname','arial')
ylabel([{'Relative'}; {'Behavior (%)'}],'fontsize',12,'fontname','arial')
title([{'Progress of Learning'};{'Across Sessions'}],'fontsize',12,'fontname','arial','fontweight','bold')
set(gca,'xtick',[1 size(beh_sum,2)])
set(gca,'xticklabel',{'1';num2str(size(beh_sum,2))})
set(gca,'ytick',[50 100])
set(gca,'yticklabel',{'50';'100'})
set(gca,'fontname','arial','fontsize',10)



set(findobj(gcf,'Type','axes'),'Fontname','arial')
set(findobj(gcf,'Type','axes'),'box','off')
set(gcf,'color','w')
