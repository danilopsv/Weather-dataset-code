%%  Tratamento dados wrf e INMEP
%    rev. 0:  01/27/2020
%    rev. 2:  10/04/2021
%    author: Danilo Silva,
%    Federal University of Espirito Santo

% Description
% 0: Initial.
% 2: Translation and organization for publication.

%% Maind Variables
% Variable      Description                                         Unit
% raw_data      Untreated data obtained by weather dataset
% raw_time      Serial date, UTC hour and local hour
% round_data	Raw data processed
% TGHIV_data	Submatrix of round data. Its a T_GHI_WS_dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [TGHIV_data, round_data] = tratamento_dados_2(raw_data)
%% Data Description  in each column 
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
%% Parameters
Tmax = 40;
Tmin = 0;
vmax = 25;
horamax = 18;
horamin = 6;

%% Purge wrong values above established limits
for ii = 1: length(raw_data)
    %Temperature
    if raw_data(ii,5) < Tmin && raw_data(ii,5) > Tmax
        raw_data(ii,5) = mean(raw_data(:,7) );
    end
    % Wind speed
    if raw_data(ii,18) > vmax
        raw_data(ii,18) = max(raw_data(:,18) );
    end    
    %% Purge wrong GHI data
    %All negative data equal a zero
    % There will be no solar radiation between 6 pm and 6 am.
    if raw_data(ii,3) < horamin || raw_data(ii,3) > horamax || raw_data(ii,23) < 0
        raw_data(ii,23) = 0;
    end    
    % Adjust wrong data at 6 am
    % Adjusts the relative error of 50%
    if raw_data(ii,3) == horamin && raw_data(ii,23) >3*raw_data(ii,24)
        raw_data(ii,23) = 1.5*raw_data(ii,24);
    end
    % Adjust wrong data at 6 pm
    % Adjusts the relative error of 50%
    if raw_data(ii,3) == horamax && raw_data(ii,23) > 3*raw_data(ii,24)
        raw_data(ii,23) = 1.5*raw_data(ii,24);
    end    
end

%% Replacing NaN values with average values of the nearest numbers

indicedata=(1:size(raw_data,1))';
% Fills NaN values using a interpolation function
% Problem: the two last lines did not update and have some NaN values
data1=bsxfun(@(x,y) interp1(y(~isnan(x)),x(~isnan(x)),y),raw_data,indicedata);
% Solution: after interpolation,  insert below the last line, a auxiliary
% line without NaN values
data1 = [data1; data1(24,:)];
% Update indicedata
indicedata=(1:size(data1,1))';
% Rerun the interpolation function
data2=bsxfun(@(x,y) interp1(y(~isnan(x)),x(~isnan(x)),y),data1,indicedata);
% Delete the auxiliary line and it's done
data2(end,:)=[];

%% Rounds
%Columns 8-10 will be truncated to integer 
round_data = [data2(:,1:3) round(data2(:,4:7),1) fix(data2(:,8:10)) ...
              round(data2(:,11:17),1) round(data2(:,18),1) round(data2(:,19:end),1)];

%% Final Array
    % TGHIV_data colunms
    %Col 1: Measurement Temperature ºC
    %Col 2: Forecasted Temperature ºC
    %Col 3: Measurement wind speed m/s
    %Col 4: Forecasted wind speed m/s
    %Col 5: Measurement GHI in kW/m²
    %Col 6: Forecasted GHI in kW/m²
TGHIV_data = [round_data(:,4) round_data(:,7) round_data(:,17) round_data(:,19) round_data(:,23) round_data(:,24)];
end

