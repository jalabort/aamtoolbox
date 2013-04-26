clear all
close all
clc

%% Model

% Specify binary DB
opt.m.bin_root = '..\BinaryDataBases\';
opt.m.type = 'Train-Original';
opt.m.name = ['Helen-' opt.m.type];
train_db = DB(opt.m.name,opt.m.bin_root);

% Specify Training DataSet
opt.m.id = 1:500;
opt.m.train_reg_exp_query = train_db.RegExpQuery(opt.m.id);

% Specify Model Options
opt.m.model_root = '..\Models\';
opt.m.n_level = 3;
opt.m.factor = {2,4,8};
opt.m.erode = 2;
opt.m.warp = 'tps';
opt.m.interp = 'cubic';
opt.m.smoothing = 'none';
opt.m.g_type = 'CentralDifference';
opt.m.sigma = {2,2,2};
opt.m.shape_model = {'pc','pc','pc'};
opt.m.tex_model = 'igo-double';
opt.m.alpha = 1.5;

% Train
Train_DS


%% Fitting

% Specify binary DB
opt.bin_root = '..\BinaryDataBases\';
opt.light = '06';
opt.name = ['MultiPIE-Light' opt.light];
test_db = DB_MultiPie(opt.name,opt.bin_root);

% Specify Training DataSet
opt.id = 51:71;
opt.exp = 6;
opt.pose = 3;
opt.test_reg_exp_query = test_db.RegExpQuery(opt.id,opt.exp,opt.pose,opt.light);

% Specify Fitting Options
opt.n_it = 100;
opt.n_c = {50,50,50};     % tex

opt.n_p1 = {12,6,3};      % global

opt.n_p2 = {4,4,4};       % mass
opt.n_r = { 2,  2,  0;    % component 1: mouth
            0,  0,  0;    % component 2: nose
            0,  0,  0;    % component 3: left eye
            0,  0,  0;    % component 4: right eye
            4,  2,  1;    % component 5: jaw
            0,  0,  0;    % component 6: left eyebrow
            0,  0,  0};   % component 7: right eyebrow
          
opt.face_detector = 'matlab';
opt.algorithm = 'daic-ecc';
opt.composition = 'papandreou';

opt.n_bin = {8,8,8};   % df
opt.sigma = {1,1,1};

% Specify Control Options
opt.show_fitting = true;
opt.show_error = false;

% Fit
Fit_DS
Test

