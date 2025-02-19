%% Let's trying processing the acc data relative to Event015test
close all

% Fixed figure layout specs
% Set dots per inch
dpi = 96;
win   = 1000;
time  = -win:win;
% 2-pole, 10Hz lowpass filter
[B,A] = butter(2,10/500,'low');

% Behaviors of interest
Behaviors = {'Event011','Event013','Event015'};
labels    = {'Start Trial','False Alarm','Stimulus'};

% Subject IDs
subjects = {'R29','V1','V4','V7','V8'};

for n = 1:length(subjects)
    disp(subjects{n})
    
    % Generate name of relevant subject directory
    folder = ['C:\Data\Plexon_Data\Test_Data\' subjects{n} '\' ...
            subjects{n} '_Accelerometer\' subjects{n} '_Acc_REDUX'];
    
    % We need the accelerometer data
    cd(folder)
    [file_Acc] = find_files(subjects{n},'_Acc');

    % Assign a row to each file
    K = length(file_Acc);
    
    % Generate figure canvas
    figure('units','pixels','Position',[1 1 8.5 11].*dpi)

    % From top to bottom
    V = 1.75*(K-1)*dpi+0.5*dpi:-1.75*dpi:0.5*dpi;
    % From left to right
    H = 1.5*dpi:2*dpi:2*(length(Behaviors)-1)*dpi+1.5*dpi;

    % Populate horizontal positions for all axes
    pos = zeros(length(H),4);
    pos(:,1) = H;

    % go to analysis diretory
    cd('C:\Program Files\MATLAB\R2006b\work\Learning_ICMS_figures\Fig4_Acc')
    
    for q = 1:K
        
        % update positions of all axes
        pos(:,2:end) = repmat([V(q) 1.25*dpi 1.25*dpi],length(H),1);

        % Load file
        load(file_Acc{q})
        [temp,file] = fileparts(file_Acc{q});
        
        % Convert data
        data_matrix

        % pack base workspace Events for function
        event = structpack(who('Eve*'));
        clear Eve*

        [event,Behavior,behavior_ts,Response_t] = Behavior_preproc(event);
        % Unpack data into base workspace
        structunpack(event)
        clear event stim*

        % Process the accelerometer data as the sum of the absolute values of each
        % channels numerical derivative.
        Nchan = size(lfp,1);
        acc   = abs(diff(lfp,[],2));
        acc   = sum(acc)./Nchan;
        
        %z-score acc
        acc   = (acc - mean(acc))/std(acc);
        
        clear lfp

        handles    = zeros(length(Behaviors),1);
        dacc_allm  = zeros(length(Behaviors),2*win + 1);
        dacc_allse = zeros(length(Behaviors),2*win + 1);
        
        for p = 1:length(Behaviors)

            handles(p) = axes('units','pixels','position',pos(p,:),'fontname','cambria','fontsize',10);

            Events = who([Behaviors{p} 'test']);
            for j = 1:length(Events)

                Event = eval(Events{j});

                if isempty(Event)
                    dacc  = zeros(1,2*win +1);
                else

                    dacc  = zeros(length(Event),2*win +1);
                    
                    for i = 1:length(Event)
                        ind  = find(time_line < Event(i),1,'last');
                        try
                            temp      =  acc(1,ind-win:ind+win);
                            % set to zero mean
                            dacc(i,:) = temp - mean(temp);
                        catch
                            if (ind + win) >length(acc)
                                temp      = acc(1,ind-win:end);
                                dacc(i,:) = [(temp-mean(temp)) zeros(1,2*win+1 - length(temp))];
                            end
                        end
                    end
                    
                    % Calculate mean and standard error
                    daccm   = mean(dacc);
                    daccse  = std(dacc);
                    dacc    = filtfilt(B,A,daccm);
                    daccse  = filtfilt(B,A,daccse);
                    
                end

                % Plot it out
                if j == 1
                    plot(time,dacc,'k','linewidth',2),hold on
                    ciplot(dacc-daccse,dacc+daccse,time,'k',0.2)
                elseif j == 2
                    plot(time,dacc,'r','linewidth',2)
                    ciplot(dacc-daccse,dacc+daccse,time,'r',0.2)
                else
                    plot(time,dacc,'b','linewidth',2)
                    ciplot(dacc-daccse,dacc+daccse,time,'b',0.2)
                end
            end
            
            % Set title
            if q == 1
                title(labels{p},'fontname','arial','fontsize',10)
            end
            
            % Set ylabel
            if q == K
                xlabel('Time (sec)','fontname','arial','fontsize',10)
            end
            
            % Set accelerometer limits to that of start trial mean+/-error
            % Set ylabel
            if p == 1
                ymax = mean(dacc) + 5*mean(daccse);
                ymin = mean(dacc) - 2.5*mean(daccse);
                
                ylabel('Acceleration (a.u.)','fontname','cambria','fontsize',10)
                
            end
            
            % log data
            dacc_allm(p,:)  = dacc;
            dacc_allse(p,:) = daccse;
            
        end
        
        % save data
        if q == 1
            eval([file '_m   = dacc_allm;'])
            eval([file '_std = dacc_allse;'])
            eval(['save(''' subjects{n} '_Acc_peth2'',''' file '_m'',''' file '_std'')'])
        else
            eval([file '_m   = dacc_allm;'])
            eval([file '_std = dacc_allse;'])
            eval(['save(''' subjects{n} '_Acc_peth2'',''' file '_m'',''' file '_std'',''-append'')'])
        end

        % Adjust y-axis limits for each row
        set(handles,'ylim',[ymin ymax])
        
        clear Eve* sp_list spikes time_line acc lfp_list
    end
    
    % Adjust xticks
    h = findobj(gcf,'Type','axes');
    set(h,'xticklabel','-1|0|1')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Global figure Settings %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    set(findobj(gcf,'Type','axes'),'box','off')
    set(gcf,'color','w')

    set(gcf,'PaperPositionMode','manual','PaperUnits','inches','PaperPosition',[0 0 8.5 11])
    eval(['print(''-dpng'',''-r600'',''' subjects{n} '_Acc_peth2'')'])
    close all
end

system('%windir%\system32\rundll32.exe PowrProf.dll, SetSuspendState')
