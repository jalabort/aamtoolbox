clear all
%close all
clc


%% Load or Create M_2D

% shared options
Shared_Model_Helen


%% Create F_2D

% specific options
opt.fitter = 'pic-ssd';

% shared options
Shared_Fitter_Helen
 

%% Fit DS

% shared options
Shared_Fit_Helen


%% Test DS

% shared options
Shared_Test_Helen

