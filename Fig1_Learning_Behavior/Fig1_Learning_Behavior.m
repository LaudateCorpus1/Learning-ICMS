%% Figure 2: Learning_Behavior_sum
% Details of single subject behavior (V8)
clear
close all

% Set dots per inch
dpi = 96;
figure('units','pixels','Position',[1 1 8.5 11].*dpi)

% From left to right
H = [2.25 3.75];

% From bottom to top
V = [2.1 3.525 4.95 6.4];

% Layout of axes
pos      = [H(1)  V(4)   1 1;
            H(2)  V(4)   1 1;
            
            H(1)  V(3)   1 1;
            H(2)  V(3)   1 1;
            
            H(1)  V(2)   1 1;
            H(2)  V(2)   1 1;
            
            
            H(1)  V(1)   1 1;
            H(2)  V(1)   1 1].*dpi;
            

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% STAGES OF LEARNING %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%
%%% Stage 0 %%%
%%%%%%%%%%%%%%%
cd('C:\Data\Plexon_Data\Test_Data\Learning\V8')
load('V8_032409_Events.mat')

event = structpack(who('Eve*'));
clear Eve*

[event] = Behavior_preproc(event);
structunpack(event)

% Determine response times on tone trials via Event016 and
% Event012test
Response_t    = zeros(length(Event012test),1);
for q = 1:length(Event012test)
    
    ind = find(Event015 < Event012test(q),1,'last');
    Response_t(q) = Event012test(q) - Event015(ind); 
end

% Initialize behavioral quantities of interest for evaluating test trials
% and then infer testing trials information
Behavior    = zeros(3, length(Event011test));
behavior_ts = zeros(1, length(Event011test));

stim2succ   = [];
stim2miss   = [];

suc_ct      = 0;
suc_ind     = zeros(1,length(Event012));

fa_ct       = 0;
fa_ind      = zeros(1,length(Event013));

miss_ct     = 0;
miss_ind    = zeros(1,length(Event014));

stim_ind    = zeros(1,length(Event015));

for n = 1:length(Event011test)
    suc  = find(Event012 > Event011test(n),1,'first');
    fa   = find(Event013 > Event011test(n),1,'first');
    miss = find(Event014 > Event011test(n),1,'first');
    
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
        behavior_ts(n)  = val;
    else
        Behavior(:,n)   = Behavior(:,n-1);
        Behavior(ind,n) = Behavior(ind,n-1) + 1;
        behavior_ts(n)  = val;
    end

    % If this particular trial resulted in a success or a miss, grab the
    % timestamp of the preceding stimulus
    
    if ind == 1
        s2s            = find(Event015 < suc_ck,1,'last');
        stim2succ      = [stim2succ; Event015(s2s)];
        suc_ct         = suc_ct +1;
        suc_ind(suc)   = 1;
        stim_ind(s2s)  = 1;
    elseif ind == 2
        fa_ct          = fa_ct +1;
        fa_ind(fa)     = 1;
    elseif ind == 3
        s2m            = find(Event015 < miss_ck,1,'last');
        stim2miss      = [stim2miss; Event015(s2m)];
        miss_ct        = miss_ct +1;
        miss_ind(miss) = 1;
        stim_ind(s2m)  = 1;
    end
end

win = 40;
% Axes 1
axes('units','pixels','position',pos(1,:)),
    
    temp1 = zeros(1,size(Behavior,2)-win+1);
    temp2 = zeros(1,size(Behavior,2)-win+1);
    temp3 = zeros(1,size(Behavior,2)-win+1);
    
    for n = 1:size(Behavior,2)-win+1
        temp1(n) = (Behavior(1,(win-1)+n) - Behavior(1,n))/win;
        temp2(n) = (Behavior(2,(win-1)+n) - Behavior(2,n))/win;
        temp3(n) = (Behavior(3,(win-1)+n) - Behavior(3,n))/win;
    end

    Behavior = 100.*[temp1;temp2;temp3];
%     Behavior = 100.*(Behavior./repmat(sum(Behavior),3,1));
    plot(Behavior','LineWidth',2.5)
    axis([1 size(Behavior,2) 0 100])    
    ticks = get(gca,'xtick');
    set(gca,'xtick',[1 ticks(end)])
    set(gca,'xticklabel',[num2str(win) '|' num2str(ticks(end)+win)])
    ylabel([{'Probability'}; {'of Response'}],'Fontsize',10,'Fontname','arial')
    title('Response Profile','Fontsize',12,'Fontname','arial','fontweight','bold')
    legend('Correct (C)','False Alarm (FA)','Miss (M)','Location',[0.33 0.09 .05 .05],'orientation','vertical')
    xlim([0 size(Behavior,2)])
    temp1 = get(gca,'children');
    temp2 = get(temp1,'color');
    temp2{2} = [0 1 0];
    for q = 1:length(temp1)
        set(temp1(q),'color',temp2{q})
    end
    set(gca,'Fontsize',10)
    
% Axes 2
axes('units','pixels','position',pos(2,:)),
    plot(1:length(Response_t),Response_t,'marker','o','linestyle','none',...
        'markeredgecolor',[0.5412 0.5490 0.4510],'markerfacecolor',[0.5412 0.5490 0.4510],'markersize',4)
    ylabel('Time (sec)','Fontsize',10,'Fontname','arial')
    title('Response Time','Fontsize',12,'Fontname','arial','fontweight','bold')
    xlim([0 length(Response_t)+1])
    set(gca,'xtick',[1 length(Response_t) - mod(length(Response_t),2)])
    ylim([0 4])
    set(gca,'Fontsize',10)
    
%%%%%%%%%%%%%%%
%%% Stage 1 %%%
%%%%%%%%%%%%%%%
cd('C:\Data\Plexon_Data\Test_Data\V8\V8 Spikes & Events')
load('V8_032909_spikes&Events1_16.mat')

event = structpack(who('Eve*'));
[event,Behavior,behavior_ts,Response_t] = Behavior_preproc(event);

% Axes 3
axes('units','pixels','position',pos(3,:)),
    
    temp1 = zeros(1,size(Behavior,2)-win+1);
    temp2 = zeros(1,size(Behavior,2)-win+1);
    temp3 = zeros(1,size(Behavior,2)-win+1);
    
    for n = 1:size(Behavior,2)-win+1
        temp1(n) = (Behavior(1,(win-1)+n) - Behavior(1,n))/win;
        temp2(n) = (Behavior(2,(win-1)+n) - Behavior(2,n))/win;
        temp3(n) = (Behavior(3,(win-1)+n) - Behavior(3,n))/win;
    end

    Behavior = 100.*[temp1;temp2;temp3];
%     Behavior = 100.*(Behavior./repmat(sum(Behavior),3,1));
    plot(Behavior','LineWidth',2.5)
    axis([1 size(Behavior,2) 0 100])
    ticks = get(gca,'xtick');
    set(gca,'xtick',[1 ticks(end)])
    set(gca,'xticklabel',[num2str(win) '|' num2str(ticks(end)+win)])
    xlim([0 size(Behavior,2)])
    temp1 = get(gca,'children');
    temp2 = get(temp1,'color');
    temp2{2} = [0 1 0];
    for q = 1:length(temp1)
        set(temp1(q),'color',temp2{q})
    end
    set(gca,'Fontsize',10)

% Axes 4
axes('units','pixels','position',pos(4,:)),
    plot(1:length(Response_t),Response_t,'marker','o','linestyle','none',...
        'markeredgecolor',[0.5412 0.5490 0.4510],'markerfacecolor',[0.5412 0.5490 0.4510],'markersize',4)
    xlim([0 length(Response_t)+1])
    set(gca,'xtick',[1 length(Response_t) - mod(length(Response_t),2)])
    ylim([0 4])
    set(gca,'Fontsize',10)

%%%%%%%%%%%%%%%
%%% STAGE 2 %%%
%%%%%%%%%%%%%%%    
cd('C:\Data\Plexon_Data\Test_Data\V8\V8 Spikes & Events')
load('V8_033109_spikes&Events1_16.mat')

event = structpack(who('Eve*'));
[event,Behavior,behavior_ts,Response_t] = Behavior_preproc(event);

% Axes 5
axes('units','pixels','position',pos(5,:)),
    
    temp1 = zeros(1,size(Behavior,2)-win+1);
    temp2 = zeros(1,size(Behavior,2)-win+1);
    temp3 = zeros(1,size(Behavior,2)-win+1);
    
    for n = 1:size(Behavior,2)-win+1
        temp1(n) = (Behavior(1,(win-1)+n) - Behavior(1,n))/win;
        temp2(n) = (Behavior(2,(win-1)+n) - Behavior(2,n))/win;
        temp3(n) = (Behavior(3,(win-1)+n) - Behavior(3,n))/win;
    end

    Behavior = 100.*[temp1;temp2;temp3];    
%     Behavior = 100.*(Behavior./repmat(sum(Behavior),3,1));
    plot(Behavior','LineWidth',2.5)
    axis([1 size(Behavior,2) 0 100])
    ticks = get(gca,'xtick');
    set(gca,'xtick',[1 ticks(end)])
    set(gca,'xticklabel',[num2str(win) '|' num2str(ticks(end)+win)])
    xlim([0 size(Behavior,2)])
    temp1 = get(gca,'children');
    temp2 = get(temp1,'color');
    temp2{2} = [0 1 0];
    for q = 1:length(temp1)
        set(temp1(q),'color',temp2{q})
    end
    set(gca,'Fontsize',10)

% Axes 6
axes('units','pixels','position',pos(6,:)),
    plot(1:length(Response_t),Response_t,'marker','o','linestyle','none',...
        'markeredgecolor',[0.5412 0.5490 0.4510],'markerfacecolor',[0.5412 0.5490 0.4510],'markersize',4)    
    xlim([0 length(Response_t)+1])
    set(gca,'xtick',[1 length(Response_t) - mod(length(Response_t),2)])
    ylim([0 4])
    set(gca,'Fontsize',10)

%%%%%%%%%%%%%%%
%%% STAGE 3 %%%
%%%%%%%%%%%%%%%
cd('C:\Data\Plexon_Data\Test_Data\V8\V8 Spikes & Events')
load('V8_040109_spikes&Events1_16.mat')

event = structpack(who('Eve*'));
[event,Behavior,behavior_ts,Response_t] = Behavior_preproc(event);

% Axes 7
axes('units','pixels','position',pos(7,:)),
    
    temp1 = zeros(1,size(Behavior,2)-win+1);
    temp2 = zeros(1,size(Behavior,2)-win+1);
    temp3 = zeros(1,size(Behavior,2)-win+1);
    
    for n = 1:size(Behavior,2)-win+1
        temp1(n) = (Behavior(1,(win-1)+n) - Behavior(1,n))/win;
        temp2(n) = (Behavior(2,(win-1)+n) - Behavior(2,n))/win;
        temp3(n) = (Behavior(3,(win-1)+n) - Behavior(3,n))/win;
    end

    Behavior = 100.*[temp1;temp2;temp3];
%     Behavior = 100.*(Behavior./repmat(sum(Behavior),3,1));
    plot(Behavior','LineWidth',2.5)
    xlabel('Trial #','Fontsize',10,'Fontname','arial')
    axis([1 size(Behavior,2) 0 100])
    ticks = get(gca,'xtick');
    set(gca,'xtick',[1 ticks(end)])
    set(gca,'xticklabel',[num2str(win) '|' num2str(ticks(end)+win)])
    xlim([0 size(Behavior,2)])
    temp1 = get(gca,'children');
    temp2 = get(temp1,'color');
    temp2{2} = [0 1 0];
    for q = 1:length(temp1)
        set(temp1(q),'color',temp2{q})
    end
    set(gca,'Fontsize',10)

% Axes 8
axes('units','pixels','position',pos(8,:)),
    plot(1:length(Response_t),Response_t,'marker','o','linestyle','none',...
        'markeredgecolor',[0.5412 0.5490 0.4510],'markerfacecolor',[0.5412 0.5490 0.4510],'markersize',4)
    xlabel('Correct Trial #','Fontsize',10,'Fontname','arial')
    xlim([0 length(Response_t)+1])
    set(gca,'xtick',[1 length(Response_t) - mod(length(Response_t),2)])
    ylim([0 4])
    set(gca,'Fontsize',10)
    
set(findobj(gcf,'Type','axes'),'Fontname','arial')
set(findobj(gcf,'Type','axes'),'box','off')
set(gcf,'color','w')
set(gcf,'PaperPositionMode','manual','PaperUnits','inches','PaperPosition',[0 0 8.5 11])
