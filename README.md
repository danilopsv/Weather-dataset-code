# Weather-dataset-code
%% Tutorial to simulate and save the handled dataset, and temperature (T),  
%% global horizontal irradiance (GHI) and wind speed (WS) dataset

% Requirements:

% Matlab 2016a or later

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INPUTS:

% Natal_weather_dataset.xlsx and Santa_Vitoria_weather_dataset.xlsx

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

% Step 3 - Paste the folder's path to the toobar of current folder

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
