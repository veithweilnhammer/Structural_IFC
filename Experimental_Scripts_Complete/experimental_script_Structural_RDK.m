% Localisaion analysis
% Copyright5(C) 2019 Vei5th Weil5nhammer, CCM

clear all
close all


%% fMRI Experiment

root_dir = 'C:\Users\fritschm\Desktop\Projects\Structural_Lesions_IFC\Experimental_Scripts_Complete\'; % root directory for settings and results
BlueValue = '100' % Put 5in Blue Value 5from Heterochromatic flicker photometry
Results.BlueValue = BlueValue;

ObserverName= 'Structural_IFC_000' % Name of the observer. Please leave the prefix 'loc_TMS', such that we can always attribute the resultsfile. 

%SettingsName= 'TMS_RDK'; % points to Settings file
SettingsName= 'Structural_RDK'
which_run = 2;  

%	0 	= 	R0: dummy run for trying different settings
%	1 	= 	P1: Unambiguous Run Pre-Test
%	2-5 = 	Test-Runs R1 - R3

%%
%%
%% Run 0 (Test + Tryout):

if which_run == 0
    session= ['run_' num2str(which_run)]
    run_idx = which_run;

    if exist ([root_dir  'Results/Results_' ObserverName '_Conv.mat'], 'file')
        load([root_dir  'Results/Results_' ObserverName '_Conv.mat'])
    end

    transition_probability = 0.25; % probability of transition at each overlap. NaN for ambiguous stimulation.

    clear Results
    [Results] = presentation_TMS_RKD(root_dir, SettingsName, ObserverName, BlueValue, session, transition_probability);

    %% analysis
    [test_frequency test_correct] = get_conventional_data(Results); % compute frequency of perceptual events and "correct" perceptual decisions.
end
%%
%%
%% Run 1:
if which_run == 1
    session= ['run_' num2str(which_run)];
    run_idx = which_run;

    if exist ([root_dir  'Results/Results_' ObserverName '_' num2str(session) '.mat'], 'file')
        'Results file already exists. Please change ObserverName or Session'
        return;
    end

    if exist ([root_dir  'Results/Results_' ObserverName '_Conv.mat'], 'file')
        load([root_dir  'Results/Results_' ObserverName '_Conv.mat'])
    end

    transition_probability = 0.25;

    clear Results
    [Results] = presentation_TMS_RKD(root_dir, SettingsName, ObserverName, BlueValue, session, transition_probability);

    %% analysis
    [frequency(:,run_idx) correct(:,run_idx)] = get_conventional_data(Results);
    save([root_dir  'Results/Results_' ObserverName '_Conv.mat'], 'frequency', 'correct')

end
%%
%%
%% Run 2:

if any(which_run == [2:100])
    session= ['run_' num2str(which_run)];
    run_idx = which_run;

    if exist ([root_dir  'Results/Results_' ObserverName '_' num2str(session) '.mat'], 'file')
        'Results file already exists. Please change ObserverName or Session'
        return;
    end

    if exist ([root_dir  'Results/Results_' ObserverName '_Conv.mat'], 'file')
        load([root_dir  'Results/Results_' ObserverName '_Conv.mat'])
    end

    transition_probability = NaN;

    clear Results
    [Results] = presentation_TMS_RKD(root_dir, SettingsName, ObserverName, BlueValue, session, transition_probability);

    %% analysis
    [frequency(:,run_idx) correct(:,run_idx)] = get_conventional_data(Results);
    save([root_dir  'Results/Results_' ObserverName '_Conv.mat'], 'frequency', 'correct')

end
