%%  .mat and .dat files of forecasted (WRF) and measured dataset (INMEP)
%    rev. 0:  10/11/2021
%    author: Danilo Silva,
%    Federal University of Espirito Santo
% Descriprion
% 0: Translation and organization for publication.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tutorial to simulate and save the handled dataset, and temperature (T),  
%% global horizontal irradiance (GHI) and wind speed (WS) dataset
% This algorithm consists of a weather data conversion of the  
% weather_dataset.xlsx to .mat/.dat. This algorithm was developed based on  
% the research article “Management of an island and grid-connected microgrid 
% using hybrid economic model predictive control with weather data",
% https://doi.org/10.1016/j.apenergy.2020.115581
% Requirements:
% Matlab 2016a or later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS:
% Natal_weather_dataset.xlsx and Santa_Vitoria_weather_dataset.xlsx
%
% OUTPUTS: 
% localname_handled_dataset.mat/.dat and localname_T_GHI_WS_dataset.mat/.dat
% localname = Natal or Santa_Vitoria
    % T_GHI_WS_dataset colunms
    %Col 1: Measurement Temperature ºC
    %Col 2: Forecasted Temperature ºC
    %Col 3: Measurement wind speed m/s
    %Col 4: Forecasted wind speed m/s
    %Col 5: Measurement GHI in W/m²
    %Col 6: Forecasted GHI in W/m²
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1 - Unzip the file into a selected folder 
%          (suggestion: Processing weather Code)
% Step 2 - Open the Matlab
%
% Step 3 - Paste the folder's path to the toobar of current folder
% 
% Step 4 - Above the current folder Matlab environmet, click on the icon 
%           "Up one Level"
% Step 5 - Click on the code's folder with the right mouse button and  
%          select "add to path" and "selected folders and subfolders"
% Step 6 - In the current folder Matlab environmet, open the code's folder
%          and open the file processing_weather_dataset_0.m
% Step 7 - Run the processing_weather_dataset_0.m and select the file
%          localname_weather_dataset.xlsx 
%          localname = Natal or Santa_Vitoria
% Step 8 - Check if the .dat/mat files were generated correctly.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main Variables
% Variable                  Description
% raw_d_natal               Natal raw measured and forecasted dataset
% raw_d_santavitoria        Santa Vitoria raw measured and forecasted dataset
% TGHIV_data_natal          Natal Temperature, irradiance and wind speed
%                           dataset
% TGHIV_data_santavitoria   Santa Vitoria Temperature, irradiance and wind
%                           speed dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data Description in each column - INMET Worksheet/handled_dataset
% Col	Description
% 1     Serial date
% 2     UTC hour
% 3      Local Hour	
% 4      Temperature (ºC)	Inst,
% 5              Max,
% 6              Min,
% 7              WRF
% 8      Humidity (%)	Inst,
% 9              Max,
% 10              Min,
% 11      Dew point (ºC)	Inst,
% 12             Max,
% 13             Min,
% 14 	Pressure (hPa)	Inst,
% 15             Max,
% 16             Min,
% 17 	Wind speed (m/s)	,
% 18             Dir, (º)
% 19             Wind speed (WRF)
% 20             DIR (WRF)
% 21             Max Wind speed,
% 22             GHI	(kJ/m2)
% 23             GHI (W/m2)
% 24             GHI WRF (W/m2)
% 25             Precipitation	(mm)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Clear Matlab
close all
clear
clc
%% Raw measured and forecast data (Raw data)
% Weather database, INMET sheet - section 3.2.2	of the Data in Brief (DIB) 
% manuscript
% Sampling time: 1 hour

%% OPEN the localname_weather_dataset.xlsx file 
[file,path] = uigetfile('*.xlsx');
if isequal(file,0)
    disp('User selected Cancel');
    acumula = 0;    
    return
else
    disp(['User selected ', fullfile(file,path)]);
    close all
end

xlsxfile = fullfile(path,file);
% Split the location of the rest of the filename
exstr=strsplit(file, '_');

% Choose the location: Natal or Santa Vitoria do Palmar accordind to the
% worksheet weather_dataset
if strcmp(exstr{1,1},'Natal') % 1 - Natal
    raw_d_natal = xlsread(xlsxfile,'INMET','A6:Y9098','basic');
    %% Data processing
    % Section 3.2.3	of DIB manuscript - handled dataset
    % Section 3.2.4	of DIB manuscript - Temperature, irradiance and  
    % wind speed dataset
    [TGHIV_data_natal, round_data_natal] = tratamento_dados_2(raw_d_natal);
    % .dat
    filedat_Natal = 'Natal_handled_dataset.dat';
    fulldat_Natal = fullfile(path,filedat_Natal);
    save(fulldat_Natal,'round_data_natal','-ascii','-tabs');
    filedat_Natal = 'Natal_T_GHI_WS_dataset.dat';
    fulldat_Natal = fullfile(path,filedat_Natal);
    save(fulldat_Natal,'TGHIV_data_natal','-ascii','-tabs');
    % .mat
    filemat_Natal = 'Natal_handled_dataset.mat';
    fullmat_Natal = fullfile(path,filemat_Natal);
    save(fullmat_Natal,'round_data_natal');
    filemat_Natal = 'Natal_T_GHI_WS_dataset.mat';
    fullmat_Natal = fullfile(path,filemat_Natal);
    save(fullmat_Natal,'TGHIV_data_natal');
end
if strcmp(exstr{1,1},'Santa') %2 - Santa Vitoria do Palmar
    raw_d_santavitoria = xlsread(xlsxfile,'INMET','A6:Y8186','basic');
    %% Data processing
    % Section 3.2.3	of DIB manuscript - handled dataset
    % Section 3.2.4	of DIB manuscript - Temperature, irradiance and 
    % wind speed dataset
    [TGHIV_data_santavitoria, round_data_santavitoria] = tratamento_dados_2(raw_d_santavitoria);
    %% Save files .mat and .dat
    % .dat    
    filedat_Santa_Vitoria = 'Santa_Vitoria_handled_dataset.dat';
    fulldat_Santa_Vitoria = fullfile(path,filedat_Santa_Vitoria);
    save(fulldat_Santa_Vitoria,'round_data_santavitoria','-ascii','-tabs');
    filedat_Santa_Vitoria = 'Santa_Vitoria_T_GHI_WS_dataset.dat';
    fulldat_Santa_Vitoria = fullfile(path,filedat_Santa_Vitoria);
    save(fulldat_Santa_Vitoria,'TGHIV_data_santavitoria','-ascii','-tabs');
    % .mat    
    filemat_Santa_Vitoria = 'Santa_Vitoria_handled_dataset.mat';
    fullmat_Santa_Vitoria = fullfile(path,filemat_Santa_Vitoria);
    save(fullmat_Santa_Vitoria,'round_data_santavitoria');
    filemat_Santa_Vitoria = 'Santa_Vitoria_T_GHI_WS_dataset.mat';
    fullmat_Santa_Vitoria = fullfile(path,filemat_Santa_Vitoria);
    save(fullmat_Santa_Vitoria,'TGHIV_data_santavitoria');
end
% If the spreadsheet does not contain "Natal" or "Santa", it shows an error 
if ~strcmp(exstr{1,1},'Santa')&& ~strcmp(exstr{1,1},'Natal')
    disp('Incorrect worksheet! Run again and choose another worksheet ')
    return
end