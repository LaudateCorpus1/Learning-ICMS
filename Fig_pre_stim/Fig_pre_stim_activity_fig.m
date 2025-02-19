% Figure: Pre-stimulus activity
close all
clear

%%%%%%%%%%%%%%%%%%%%%
%%% Figure layout %%%
%%%%%%%%%%%%%%%%%%%%%
% Set dots per inch
dpi = 96;
figure('units','pixels','Position',[1 1 8.5 11].*dpi)

% From left to right
H = [1 4.2 6.1];

% From bottom to top
V = [1 4.5 3.0 5.20];

% Layout of axes
pos      = [H(1)  V(2)  2.5 2.5
            H(1)  V(1)  2.5 2.5
            
            H(2)  V(4)  1.75 1.75
            H(3)  V(4)  1.75 1.75
            
            H(2)  V(3)  1.75 1.75
            H(3)  V(3)  1.75 1.75].*dpi;


% Load example data
cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig_pre_stim')
load('Fig_pre_stim_activity_example')

% Representative histograms for dbase and dstim
axes('units','pixels','position',pos(1,:),'fontname','arial','fontsize',10),
    hist(pd_base(:),bins),
    hold on,hist(pd_stim(:),bins),
    kids = get(gca,'children');
    set(kids(2),'Edgecolor','k','Facecolor','k','EdgeAlpha',1,'FaceAlpha',1)
    set(kids(1),'Edgecolor',[0.3912 0.3990 0.350],'Facecolor',...
        [0.3912 0.3990 0.350],'EdgeAlpha',0.8,'FaceAlpha',0.8)
    l = legend('\Deltabase','\Deltastim','location','northwest');
    xlim([-40 40])

    title('Paired Difference Distributions','fontname','arial','fontsize',10)
    ylabel('Counts','fontname','arial','fontsize',10)
    xlabel('Data Limits','fontname','arial','fontsize',10)
    set(gca,'box','off')
    
temp1 = pd_base(:);
temp2 = pd_stim(:);
[temp,ind]=sort(temp1);

% scatter plot of dbase vs dstim
axes('units','pixels','position',pos(2,:),'fontname','arial','fontsize',10),
    plot(temp1(ind),temp2(ind),'.k','markersize',5)
    ylim([-40 40])
    xlim([-40 40])

    p1 = polyfit(temp1,temp2,0);
    p2 = polyfit(temp2,temp1,0);
    line(get(gca,'xlim'),[p1 p1],'color','k','linestyle','--')
    line([p2 p2],get(gca,'ylim'),'color','k','linestyle','--')
    text(-35, 35,['r = ' sprintf('%4.2f',corr(pd_base(:),pd_stim(:)))])

    title('\Deltabase vs \Deltastim','fontname','arial','fontsize',10)
    xlabel('\Deltabase data limits','fontname','arial','fontsize',10)
    ylabel('\Deltastim data limits','fontname','arial','fontsize',10)
    set(gca,'box','off')
    
% Data Directory        
cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig_pre_stim')
% Subject IDs
subjects = {'R29*','V1*','V4*','V7*','V8*'};
load('Fig_pre_stim_activity_sub')

% Grab the data
vars1 = who(subjects{1});
vars2 = who(subjects{2});
vars3 = who(subjects{3});
vars4 = who(subjects{4});
vars5 = who(subjects{5});
    
% Grab max and min for signal and internal noise
maxs  = zeros(length(vars1),2);
mins  = zeros(length(vars1),2);

for n = 1:length(vars1)
    temp1    = eval(vars1{n});
    temp2    = eval(vars2{n});
    temp3    = eval(vars3{n});
    temp4    = eval(vars4{n});
    temp5    = eval(vars5{n});
    
    maxs(n,:) = nanmax([temp1(:,1:2);temp2(:,1:2);temp3(:,1:2);temp4(:,1:2);temp5(:,1:2)]);
    mins(n,:) = nanmin([temp1(:,1:2);temp2(:,1:2);temp3(:,1:2);temp4(:,1:2);temp5(:,1:2)]);
end

% Calculate the max and min for each metric
ymin = floor(min(mins))-0.5;
ymax = ceil(max(maxs));

% temp to correct for outlier
ymax(2) = 65;

for n = 1:length(vars1)
    
    % Data for each subject
    temp1 = eval(vars1{n});
    temp2 = eval(vars2{n});
    temp3 = eval(vars3{n});
    temp4 = eval(vars4{n});
    temp5 = eval(vars5{n});
    
    % R29 has channels 17-32 as test
    ind1  = ~logical(temp1(:,4));
    
    % All others have chaneels 1-16 as test
    ind2  = logical(temp2(:,4));
    ind3  = logical(temp3(:,4));
    ind4  = logical(temp4(:,4));
    ind5  = logical(temp5(:,4));
    
    % Test Hemisphere data for each subject
    sub1  = temp1(ind1,:);
    [a,b] = sort(sub1(:,3),1);
    sub1  = sub1(b,:);
    
    sub2  = temp2(ind2,:);
    [a,b] = sort(sub2(:,3),1);
    sub2  = sub2(b,:);
    
    sub3  = temp3(ind3,:);
    [a,b] = sort(sub3(:,3),1);
    sub3  = sub3(b,:);
    
    sub4  = temp4(ind4,:);
    [a,b] = sort(sub4(:,3),1);
    sub4  = sub4(b,:);
    
    sub5  = temp5(ind5,:);
    [a,b] = sort(sub5(:,3),1);
    sub5  = sub5(b,:);
    
    h1 = axes('units','pixels','position',pos(n+2,:),'fontname','arial');
        plot(sub1(:,3),sub1(:,1),'+k'),hold on,
        plot(sub2(:,3),sub2(:,1),'ok'),
        plot(sub3(:,3),sub3(:,1),'sk'),
        plot(sub4(:,3),sub4(:,1),'vk'),
        plot(sub5(:,3),sub5(:,1),'*k'),
        
        % fit a line to the group data
        h = get(gca,'children');
        x = cell2mat(get(h,'xdata')');
        y = cell2mat(get(h,'ydata')');
        p = polyfit(x(~isnan(y)),y(~isnan(y)),1);
        x = 0:.2:2.25;
        y = polyval(p,x);
        plot(x,y,'--k','linewidth',2)
        set(gca,'box','off')
        
        ylim([ymin(1) ymax(1)])
        xlim([0 2.25])
        
        if n == 1
            title('Learning of ICMS: Early','fontname','arial','fontsize',10)
            ylabel('median(\Deltastim) - median(\Deltabase)','fontname','arial','fontsize',10)
            leg = legend('S1','S2','S3','S4','S5','location','northwest','orientation','horizontal');
            set(leg,'box','on')
        else
            title('Learning of ICMS: Late','fontname','arial','fontsize',10)
            set(gca,'yticklabel','')
        end
        
    h2 = axes('units','pixels','position',pos(n+4,:),'fontname','arial');
        plot(sub1(:,3),sub1(:,2),'+k'),hold on,
        plot(sub2(:,3),sub2(:,2),'ok'),
        plot(sub3(:,3),sub3(:,2),'sk'),
        plot(sub4(:,3),sub4(:,2),'vk'),
        plot(sub5(:,3),sub5(:,2),'*k'),
        
        % fit a line to the group data
        h = get(gca,'children');
        x = cell2mat(get(h,'xdata')');
        y = cell2mat(get(h,'ydata')');
        p = polyfit(x(~isnan(y)),y(~isnan(y)),1);
        x = 0:.2:2.25;
        y = polyval(p,x);
        plot(x,y,'--k','linewidth',2)
        set(gca,'box','off')
        
        ylim([ymin(2) ymax(2)])
        xlim([0 2.25])
        xlabel([{'Distance from'}; {'stimulating electrode (mm)'}],'fontname','arial','fontsize',10)

        if n == 1
            ylabel('variance(\Deltastim) - variance(\Deltabase)','fontname','arial','fontsize',10)
        else
            set(gca,'yticklabel','')
        end
        
end

set(gcf,'color','w')
set(gcf,'PaperPositionMode','manual','PaperUnits','inches','PaperPosition',[0 0 8.5 11])
