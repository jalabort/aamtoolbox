clear all
%close all
clc


%% Load or Create M_2D

% shared options
Shared_Model_LFPW


%% Create F_2D

% specific options
opt.fitter = 'sic-ssd';

% shared options
Shared_Fitter_LFPW
 

%% Fit DS

% shared options
Shared_Fit_LFPW


%% Test DS

% shared options
Shared_Test_LFPW

