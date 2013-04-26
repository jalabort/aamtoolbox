clear all
close all
clc

%% Model

% Specify binary DB
opt.m.bin_root = '../BinaryDataBases/';
opt.m.type = 'Train';
opt.m.name = ['LFPW-' opt.m.type];
train_db = DB(opt.m.name,opt.m.bin_root);

% Specify Training DataSet
opt.m.id = 1:811;
opt.m.train_reg_exp_query = train_db.RegExpQuery(opt.m.id);

% Specify Model Options
opt.m.model_root = '../Models/';
opt.m.n_level = 3;
opt.m.factor = {1,2,3};
opt.m.erode = 2;
opt.m.warp = 'pwa';
opt.m.interp = 'bilinear';
opt.m.smoothing = 'gaussian';
opt.m.g_type = 'CentralDifference';
opt.m.sigma = {1,1,1};
opt.m.shape_model = {'cb-pc3','cb-pc3','cb-pc3'};
opt.m.tex_model = 'igo-double';
opt.m.alpha = 1.5;

% Train
Train_DS


%% Fitting

% Specify binary DB
opt.bin_root = '../BinaryDataBases/';
opt.light = '06';
opt.name = ['MultiPIE-Light' opt.light];
test_db = DB_MultiPie(opt.name,opt.bin_root);

% Specify Training DataSet
opt.id = 51:140;
opt.exp = 6;
opt.pose = 1:5;
opt.test_reg_exp_query = test_db.RegExpQuery(opt.id,opt.exp,opt.pose,opt.light);

% Specify Fitting Options
opt.n_it = 150;
opt.n_c = {50,50,50};  % tex

opt.n_p1 = {12,6,3};      % global

opt.n_p2 = {4,4,3};       % mass
opt.n_r = { 4,  2,  2;    % component 1: mouth
            2,  1,  0;    % component 2: nose
            2,  0,  0;    % component 3: left eye
            2,  0,  0;    % component 4: right eye
            4,  2,  2;    % component 5: jaw
            1,  0,  0;    % component 6: left eyebrow
            1,  0,  0};   % component 7: right eyebrow
          
opt.face_detector = 'gr-tr';
opt.algorithm = 'daic-ecc';
opt.composition = 'baker';

opt.n_bin = {8,8,8};   % df
opt.sigma = {1,1,1};

% Specify Control Options
opt.show_fitting = true;
opt.show_error = true;

% Fit

Fit_DS
Test

