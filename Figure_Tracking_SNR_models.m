%% Figure: Tracking SNR models
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
cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig5_SNR_Models')
% Grab ensemble Firing rate data for test hemisphere
load('Figure5_Tracking_SNR_models.mat')
file_list = {R29s,V1s,V4s,V7s,V8s};

means = {R29_means; V1_means; V4_means; V7_means; V8_means};
ses   = {R29_SEs;   V1_SEs;   V4_SEs;   V7_SEs;   V8_SEs};

% Grab ensemble Firing rate data for Control hemisphere
meansC = {R29_meanb; V1_meanb; V4_meanb; V7_meanb; V8_meanb};
sesC   = {R29_SEb;   V1_SEb;   V4_SEb;   V7_SEb;   V8_SEb};

% Grab subjects' behavioral data
load('Subjects_Behavior.mat')

% Axes pointers
axs1   = 1:5;
axs2   = 6:10;
axs3   = 11:15;

for p = 1:size(pos,1)/3
    beh_sum = subject_Behavior{p};
    
    if p == 1
        metric = eval(['length(file_list{' num2str(p) '})']);
        axes('units','pixels','position',pos(axs1(p),:)),
        bar(means{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[means{p}-ses{p};means{p}+ses{p}],'color','k','linewidth',2)
        ylabel([{'SNR Model:'};{'ICMS Signal'}],'fontsize',10,'fontname','cambria')
        title(['Subject ' num2str(p)],'fontweight','bold','fontname','cambria')
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
        ylabel('Behavior (%)','fontsize',10,'fontname','cambria')
        set(gca,'xtick',[1 size(beh_sum,2)])
        set(gca,'xticklabel',{'1';num2str(size(beh_sum,2))})
        set(gca,'ytick',[50 100])
        set(gca,'yticklabel',{'50';'100'})
        set(gca,'fontname','cambria','fontsize',10)
        axis square
        
        axes('units','pixels','position',pos(axs3(p),:)),
        bar(meansC{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[meansC{p}-sesC{p};meansC{p}+sesC{p}],'color','k','linewidth',2)
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        ylabel([{'SNR Model:'};{'Internal Noise'}],'fontsize',10,'fontname','cambria')
        axis tight
       
    elseif p == 3
        metric = eval(['length(file_list{' num2str(p) '})']);
        axes('units','pixels','position',pos(axs1(p),:)),
        bar(means{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[means{p}-ses{p};means{p}+ses{p}],'color','k','linewidth',2)
        title(['Subject ' num2str(p)],'fontweight','bold','fontname','cambria')
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
        set(gca,'fontname','cambria','fontsize',10)
        axis square
        
        axes('units','pixels','position',pos(axs3(p),:)),
        bar(meansC{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[meansC{p}-sesC{p};meansC{p}+sesC{p}],'color','k','linewidth',2)
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        xlabel('Session #','fontname','cambria')
        axis tight
    else
        metric = eval(['length(file_list{' num2str(p) '})']);
        axes('units','pixels','position',pos(axs1(p),:)),
        bar(means{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[means{p}-ses{p};means{p}+ses{p}],'color','k','linewidth',2)
        title(['Subject ' num2str(p)],'fontweight','bold','fontname','cambria')
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
        set(gca,'fontname','cambria','fontsize',10)
        axis square
        
        axes('units','pixels','position',pos(axs3(p),:)),
        bar(meansC{p},'edge','k','facecolor',[0.3912 0.3990 0.350],'barwidth',1)
        line([1:metric;1:metric],[meansC{p}-sesC{p};meansC{p}+sesC{p}],'color','k','linewidth',2)
        set(gca,'xtick',[1 length(means{p})])
        set(gca,'xticklabel',{'1';num2str(metric)})
        axis tight
       
    end
end

annotation('textbox',[.35 0.81 .05 .05],'string','Signal-to-Noise Models v. Behavior','fontname','cambria','fontsize',10,'fontweight','bold','edgecolor','none');

set(findobj(gcf,'Type','axes'),'box','off')
set(gcf,'color','w')
