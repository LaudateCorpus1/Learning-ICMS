%% Figure3 cont: A neural correlate of ICMS Learning Behavior
% clear

% Set dots per inch
dpi = 96;

figure('units','pixels','Position',[0 0 8.5*dpi 11*dpi])

% From left to right
H = [0.8 2.3 3.8 5.3 6.8];

% From bottom to top
V = [1.95 3.6 4.85];

% Layout of axes
pos      = [H(1)*dpi  V(3)*dpi  1*dpi 1*dpi;
            H(2)*dpi  V(3)*dpi  1*dpi 1*dpi;
            H(3)*dpi  V(3)*dpi  1*dpi 1*dpi;
            H(4)*dpi  V(3)*dpi  1*dpi 1*dpi;
            H(5)*dpi  V(3)*dpi  1*dpi 1*dpi;
            
            H(1)*dpi  V(2)*dpi  1*dpi 1*dpi;
            H(2)*dpi  V(2)*dpi  1*dpi 1*dpi;
            H(3)*dpi  V(2)*dpi  1*dpi 1*dpi;
            H(4)*dpi  V(2)*dpi  1*dpi 1*dpi;
            H(5)*dpi  V(2)*dpi  1*dpi 1*dpi
            
            H(1)*dpi  V(1)*dpi  1*dpi 1*dpi;
            H(2)*dpi  V(1)*dpi  1*dpi 1*dpi;
            H(3)*dpi  V(1)*dpi  1*dpi 1*dpi;
            H(4)*dpi  V(1)*dpi  1*dpi 1*dpi;
            H(5)*dpi  V(1)*dpi  1*dpi 1*dpi];
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ensemble NC Learning Subplots: Axes 1 - 10 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig3_EFRV')
% Grab ensemble Firing rate data for test hemisphere
load('Subject_FFs_test_bootstrp.mat')
means = {R29_mean; V1_mean; V4_mean; V7_mean; V8_mean};
ses   = {R29_SE;   V1_SE;   V4_SE;   V7_SE;   V8_SE};

% Grab ensemble Firing rate data for Control hemisphere
load('Subject_FFs_control_bootstrp.mat')
meansC = {R29_mean; V1_mean; V4_mean; V7_mean; V8_mean};
sesC   = {R29_SE;   V1_SE;   V4_SE;   V7_SE;   V8_SE};

% Grab subjects' behavioral data
load('Subjects_Behavior.mat')

% Axes pointers
axs1   = 1:5;
axs2   = 6:10;
axs3   = 11:15;

for p = 1:size(pos,1)/3
    beh_sum = subject_Behavior{p};
    
    if p == 1
        metric = eval(['length(file_list' num2str(p) ')']);
        axes('units','pixels','position',pos(axs1(p),:)),
        bar(means{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[means{p}-ses{p};means{p}+ses{p}],'color','k','linewidth',2)
        ylabel([{'Test S1bf'};{'Ensemble Firing'};{'Rate Variablity'}],'fontsize',10,'fontname','arial')
        title(['Subject ' num2str(p)],'fontweight','bold','fontname','arial')
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        axis tight
       
        axes('units','pixels','position',pos(axs2(p),:)),
        plot(beh_sum(1,:),'ob','markerfacecolor','b','markersize',5),hold on,
        plot(beh_sum(2,:),'sg','markerfacecolor','g','markersize',5)
        plot(beh_sum(3,:),'vr','markerfacecolor','r','markersize',5)
        plot(beh_sum(3,:),'r','linewidth',2)
        plot(beh_sum(2,:),'g','linewidth',2)
        plot(beh_sum(1,:),'b','linewidth',2)
        legend('Correct','False Alarm','Miss','Location',[0.715 0.306 .05 .05],'orientation','horizontal')
        
        ylim([0 100])
        xlim([0.5 size(beh_sum,2)+0.5])
        ylabel('Behavior (%)','fontsize',10,'fontname','arial')
        set(gca,'xtick',[1 size(beh_sum,2)])
        set(gca,'xticklabel',{'1';num2str(size(beh_sum,2))})
        set(gca,'ytick',[50 100])
        set(gca,'yticklabel',{'50';'100'})
        set(gca,'fontname','arial','fontsize',10)
        axis square
        
        axes('units','pixels','position',pos(axs3(p),:)),
        bar(meansC{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[meansC{p}-sesC{p};meansC{p}+sesC{p}],'color','k','linewidth',2)
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        ylabel([{'Control S1bf'};{'Ensemble Firing'};{'Rate Variablity'}],'fontsize',10,'fontname','arial')
        axis tight
       
    elseif p == 3
        metric = eval(['length(file_list' num2str(p) ')']);
        axes('units','pixels','position',pos(axs1(p),:)),
        bar(means{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[means{p}-ses{p};means{p}+ses{p}],'color','k','linewidth',2)
        title(['Subject ' num2str(p)],'fontweight','bold','fontname','arial')
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        axis tight
       
        axes('units','pixels','position',pos(axs2(p),:)),
        plot(beh_sum(3,:),'vr','markerfacecolor','r','markersize',5),hold on,
        plot(beh_sum(2,:),'sg','markerfacecolor','g','markersize',5)
        plot(beh_sum(1,:),'ob','markerfacecolor','b','markersize',5)
        plot(beh_sum(3,:),'r','linewidth',2)
        plot(beh_sum(2,:),'g','linewidth',2)
        plot(beh_sum(1,:),'b','linewidth',2)

        ylim([0 100])
        xlim([0.5 size(beh_sum,2)+0.5])
        set(gca,'xtick',[1 size(beh_sum,2)])
        set(gca,'xticklabel',{'1';num2str(size(beh_sum,2))})
        set(gca,'ytick',[50 100])
        set(gca,'yticklabel',{'50';'100'})
        set(gca,'fontname','arial','fontsize',10)
        axis square
        
        axes('units','pixels','position',pos(axs3(p),:)),
        bar(meansC{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[meansC{p}-sesC{p};meansC{p}+sesC{p}],'color','k','linewidth',2)
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        xlabel('Session #','fontname','arial')
        axis tight
    else
        metric = eval(['length(file_list' num2str(p) ')']);
        axes('units','pixels','position',pos(axs1(p),:)),
        bar(means{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[means{p}-ses{p};means{p}+ses{p}],'color','k','linewidth',2)
        title(['Subject ' num2str(p)],'fontweight','bold','fontname','arial')
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        axis tight
       
        axes('units','pixels','position',pos(axs2(p),:)),
        plot(beh_sum(3,:),'vr','markerfacecolor','r','markersize',5),hold on,
        plot(beh_sum(2,:),'sg','markerfacecolor','g','markersize',5)
        plot(beh_sum(1,:),'ob','markerfacecolor','b','markersize',5)
        plot(beh_sum(3,:),'r','linewidth',2)
        plot(beh_sum(2,:),'g','linewidth',2)
        plot(beh_sum(1,:),'b','linewidth',2)

        ylim([0 100])
        xlim([0.5 size(beh_sum,2)+0.5])
        set(gca,'xtick',[1 size(beh_sum,2)])
        set(gca,'xticklabel',{'1';num2str(size(beh_sum,2))})
        set(gca,'ytick',[50 100])
        set(gca,'yticklabel',{'50';'100'})
        set(gca,'fontname','arial','fontsize',10)
        axis square
        
        axes('units','pixels','position',pos(axs3(p),:)),
        bar(meansC{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[meansC{p}-sesC{p};meansC{p}+sesC{p}],'color','k','linewidth',2)
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        axis tight
       
    end
end

annotation('textbox',[.30 0.81 .05 .05],'string','Ensemble Firing Rate Variability v. Behavior','fontname','arial','fontsize',10,'fontweight','bold','edgecolor','none');

set(findobj(gcf,'Type','axes'),'box','off')
set(gcf,'color','w')
