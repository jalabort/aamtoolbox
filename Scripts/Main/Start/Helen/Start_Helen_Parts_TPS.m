clear all
close all
clc

%% Model

% Specify binary DB
opt.m.bin_root = '../BinaryDataBases/';
opt.m.type = 'Train-Original';
opt.m.name = ['HelenRescaled-' opt.m.type];
train_db = DB(opt.m.name,opt.m.bin_root);

% Specify Training DataSet
opt.m.id = 1:2000;
opt.m.train_reg_exp_query = train_db.RegExpQuery(opt.m.id);

% Specify Model Options
opt.m.model_root = '../Models/';
opt.m.n_level = 3;
opt.m.factor = {1,1,1};
opt.m.erode = 3;
opt.m.warp = 'tps';
opt.m.interp = 'cubic';
opt.m.smoothing = 'none';
opt.m.g_type = 'CentralDifference';
opt.m.sigma = {1,2,3};
opt.m.shape_model = {'cb-pc6','cb-pc6','cb-pc6'};
opt.m.tex_model = 'igo-double';
opt.m.alpha = 1.99;

% Train
Train_DS


%% Fitting

% Specify binary DB
opt.bin_root = '../BinaryDataBases/';
opt.type = 'Test-Original';
opt.name = ['Helen-' opt.type];
test_db = DB(opt.name,opt.bin_root);

% Specify Fitting DataSet
opt.id = 1:330; %[5,7,15,21,49,52,64,79,88,146,174,188,208,236,287,289,303,320,322]
opt.test_reg_exp_query = test_db.RegExpQuery(opt.id);

% Specify Fitting Options
opt.n_it = 100;
opt.n_c = {50,50,50};     % tex

opt.n_p1 = {12,6,3};      % global

opt.n_p2 = {6,6,2};    % mass
opt.n_r = {4, 3, 2;    % component 1: mouth
           2, 1, 0;    % component 2: nose
           2, 1, 0;    % component 3: left eye
           2, 1, 0;    % component 4: right eye
           3, 2, 0;    % component 5: jaw
           1, 0, 0;    % component 6: left eyebrow
           1, 0, 0};   % component 7: right eyebrow
          
opt.face_detector = 'gr-tr';
opt.algorithm = 'aic-ssd';
opt.composition = 'papandreou';

opt.n_bin = {8,8,8};   % df
opt.sigma = {1,1,1};

% Specify Control Options
opt.show_fitting = true;
opt.show_error = true;

% Fit
Fit_DS


%% Test

Test

