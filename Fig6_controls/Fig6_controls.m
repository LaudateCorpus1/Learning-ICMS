%% Figure5 controls: The Control Hemisphere
clear

% Set dots per inch
dpi = 96;

figure('units','pixels','Position',[0 0 8.5*dpi 11*dpi])

% From left to right
H = [1 2.5 4.75];

% From bottom to top
V = [3.5 5.0 ];

% Layout of axes
pos      = [H(3)*dpi  V(2)*dpi  2.0*dpi 1.2*dpi;
            H(3)*dpi  V(1)*dpi  2.0*dpi 1.2*dpi;
            
            H(1)*dpi  V(1)*dpi  1.5*dpi 1.85*dpi;
            H(2)*dpi  V(1)*dpi  1.5*dpi 1.85*dpi];
        
% Grab subjects' behavioral data
load('Subjects_Behavior.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% No Transfer of Task to Opposite Hemisphere %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%
%%% V7 %%%
%%%%%%%%%%

beh_sum1 = subject_Behavior{4};

% Grab behavioral data generate for control hemisphere
cd('C:\Data\Plexon_Data\Test_Data\V7\V7 Spikes & Events')
[file_list] = find_files('V7','control');

N = length(file_list);
beh_sum1C = zeros(3,N);

for n = 1:N
    load(file_list{n})
    event = structpack(who('Eve*'));
    [event,Behavior,behavior_ts,Response_t] = Behavior_preproc(event);
    
    %Calculate percentages
    bsums        = sum(diff(Behavior,[],2),2);
    total        = sum(bsums);
    beh_sum1C(:,n) = 100.*bsums./total;
    clear Eve* eve*
end

%%%%%%%%%%
%%% V8 %%%
%%%%%%%%%%
beh_sum2 = subject_Behavior{5};

% Grab behavioral data generate for control hemisphere
cd('C:\Data\Plexon_Data\Test_Data\V8\V8 Spikes & Events')
[file_list] = find_files('V8','control');

N = length(file_list);
beh_sum2C = zeros(3,N);

for n = 1:N
    load(file_list{n})
    event = structpack(who('Eve*'));
    [event,Behavior,behavior_ts,Response_t] = Behavior_preproc(event);
    
    %Calculate percentages
    bsums        = sum(diff(Behavior,[],2),2);
    total        = sum(bsums);
    beh_sum2C(:,n) = 100.*bsums./total;
    clear Eve* eve*
end

axes('units','pixels','position',pos(1,:)),
plot(1:size(beh_sum1,2),beh_sum1(3,:),'vr','markerfacecolor','r','markersize',5),hold on,
plot(1:size(beh_sum1,2),beh_sum1(2,:),'sg','markerfacecolor','g','markersize',5)
plot(1:size(beh_sum1,2),beh_sum1(1,:),'ob','markerfacecolor','b','markersize',5)
plot(1:size(beh_sum1,2),beh_sum1(3,:),'r','linewidth',2)
plot(1:size(beh_sum1,2),beh_sum1(2,:),'g','linewidth',2)
plot(1:size(beh_sum1,2),beh_sum1(1,:),'b','linewidth',2)

plot(size(beh_sum1,2)+1:(size(beh_sum1,2) + size(beh_sum1C,2)),beh_sum1C(3,:),'vr','markerfacecolor','r','markersize',5)
plot(size(beh_sum1,2)+1:(size(beh_sum1,2) + size(beh_sum1C,2)),beh_sum1C(2,:),'sg','markerfacecolor','g','markersize',5)
plot(size(beh_sum1,2)+1:(size(beh_sum1,2) + size(beh_sum1C,2)),beh_sum1C(1,:),'ob','markerfacecolor','b','markersize',5)
plot(size(beh_sum1,2)+1:(size(beh_sum1,2) + size(beh_sum1C,2)),beh_sum1C(3,:),'r','linewidth',2)
plot(size(beh_sum1,2)+1:(size(beh_sum1,2) + size(beh_sum1C,2)),beh_sum1C(2,:),'g','linewidth',2)
plot(size(beh_sum1,2)+1:(size(beh_sum1,2) + size(beh_sum1C,2)),beh_sum1C(1,:),'b','linewidth',2)

title([{'Conditioning Through'};{'Control Hemisphere (N=2)'}],'fontname','arial','fontsize',10,'fontweight','bold')
ylabel('Behavior (%)')
text(3.5,82.5,[{'Test'}; {'S1bf'}],'HorizontalAlignment','center','fontweight','bold')
text(9.5,82.5,[{'Control'}; {'S1bf'}],'HorizontalAlignment','center','fontweight','bold')
       
ylim([0 100])
xlim([0.5 size(beh_sum1,2) + size(beh_sum1C,2)+0.5])
set(gca,'xtick',[1 size(beh_sum1,2)+size(beh_sum1C,2)])
set(gca,'xticklabel',{'1';num2str(size(beh_sum1,2) + size(beh_sum1C,2))})
set(gca,'ytick',[50 100])
set(gca,'yticklabel',{'50';'100'})
set(gca,'fontname','arial','fontsize',10)

axes('units','pixels','position',pos(2,:)),
plot(1:size(beh_sum2,2),beh_sum2(1,:),'ob','markerfacecolor','b','markersize',5),hold on,
plot(1:size(beh_sum2,2),beh_sum2(2,:),'sg','markerfacecolor','g','markersize',5)
plot(1:size(beh_sum2,2),beh_sum2(3,:),'vr','markerfacecolor','r','markersize',5)
plot(1:size(beh_sum2,2),beh_sum2(3,:),'r','linewidth',2)
plot(1:size(beh_sum2,2),beh_sum2(2,:),'g','linewidth',2)
plot(1:size(beh_sum2,2),beh_sum2(1,:),'b','linewidth',2)

plot(size(beh_sum2,2)+1:(size(beh_sum2,2) + size(beh_sum2C,2)),beh_sum2C(3,:),'vr','markerfacecolor','r','markersize',5)
plot(size(beh_sum2,2)+1:(size(beh_sum2,2) + size(beh_sum2C,2)),beh_sum2C(2,:),'sg','markerfacecolor','g','markersize',5)
plot(size(beh_sum2,2)+1:(size(beh_sum2,2) + size(beh_sum2C,2)),beh_sum2C(1,:),'ob','markerfacecolor','b','markersize',5)
plot(size(beh_sum2,2)+1:(size(beh_sum2,2) + size(beh_sum2C,2)),beh_sum2C(3,:),'r','linewidth',2)
plot(size(beh_sum2,2)+1:(size(beh_sum2,2) + size(beh_sum2C,2)),beh_sum2C(2,:),'g','linewidth',2)
plot(size(beh_sum2,2)+1:(size(beh_sum2,2) + size(beh_sum2C,2)),beh_sum2C(1,:),'b','linewidth',2)

ylim([0 100])
xlim([0.5 size(beh_sum2,2) + size(beh_sum2C,2)+0.5])
ylabel('Behavior (%)')
xlabel('Session #')
text(2.8,82.5,[{'Test'}; {'S1bf'}],'HorizontalAlignment','center','fontweight','bold')
text(7,82.5,[{'Control'}; {'S1bf'}],'HorizontalAlignment','center','fontweight','bold')

set(gca,'xtick',[1 size(beh_sum2,2)+size(beh_sum2C,2)])
set(gca,'xticklabel',{'1';num2str(size(beh_sum2,2) + size(beh_sum2C,2))})
set(gca,'ytick',[50 100])
set(gca,'yticklabel',{'50';'100'})
set(gca,'fontname','arial','fontsize',10)
legend('Correct','False Alarm','Miss','Location',[0.825 0.51 .05 .05],'orientation','vertical')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Whisker Modulation in CONTROL hemisphere and TEST hemisphere %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig5_SNR_Models')
load('Learning_ICMS_SNR_models.mat')
%%% T-Test %%%
% x = NEstds(1).*randn(50,1)+NEmeans(1);
% y = NEstds(3).*randn(50,1)+NEmeans(3);
% z = (x+y)./2;
% a = NEstdsC(1).*randn(50,1)+NEmeansC(1);
% b = NEstdsC(3).*randn(50,1)+NEmeansC(3);
% c = (a+b)/2;
% u = NEstds(2).*randn(50,1)+NEmeans(2);
% v = NEstdsC(2).*randn(50,1)+NEmeansC(2);
% q = z - u;
% r = c - v;
% [h,p] = ttest(q,r,[],'right');

axes('units','pixels','position',pos(3,:)),
       bar([1 2 3],NEmeans,'facecolor',[0.6902 0.7137 0.6118],'edgecolor','k'),hold on,
       line([1:3;1:3],[NEmeans-NEstds;NEmeans+NEstds],'color','k','linewidth',3)
       ylabel('z-score')
       title('Test','fontweight','bold')
       y = get(gca,'ylim');
       set(gca,'xticklabel','1|2|3')
       set(gca,'fontname','arial','fontsize',10)
       

axes('units','pixels','position',pos(4,:)),
       bar([1 2 3],NE_Cmeans,'facecolor','w','edgecolor','k'),hold on
       line([1:3;1:3],[NE_Cmeans-NE_CstdsC;NE_Cmeans+NE_CstdsC],'color','k','linewidth',3)
       title('Control','fontweight','bold')
       set(gca,'ylim',y)
       set(gca,'xticklabel','1|2|3','yticklabel','')
       set(gca,'fontname','arial','fontsize',10)
       


set(findobj(gcf,'Type','axes'),'box','off')
set(gcf,'color','w')

annotation('textbox',[.27 0.74 .05 .05],'string',[{'External Whisker Drive'};{'To Both Hemisphere''s S1bf'}],'HorizontalAlignment','center','fontname','arial','fontsize',10,'fontweight','bold','edgecolor','none');
annotation('textbox',[.263 0.395 .05 .05],'string','Stage #','fontname','arial','fontsize',10,'edgecolor','none');

set(gcf,'PaperPositionMode','manual','PaperUnits','inches','PaperPosition',[0 0 8.5 11])
