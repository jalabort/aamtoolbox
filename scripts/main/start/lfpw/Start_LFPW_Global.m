clear all
close all
clc

%% Model

% Specify binary DB
opt.m.bin_root = '..\BinaryDataBases\';
opt.m.type = 'Train';
opt.m.name = ['LFPW-' opt.m.type];
train_db = DB(opt.m.name,opt.m.bin_root);

% Specify Training DataSet
opt.m.id = 1:811;
opt.m.train_reg_exp_query = train_db.RegExpQuery(opt.m.id);

% Specify Model Options
opt.m.model_root = '..\Models\';
opt.m.n_level = 3;
opt.m.factor = {2,2,2};
opt.m.erode = 2;
opt.m.warp = 'pwa';
opt.m.interp = 'bilinear';
opt.m.smoothing = 'none';
opt.m.sigma = {1,1,1};
opt.m.g_type = 'CentralDifference';
opt.m.shape_model = {'cb-pc','cb-pc','cb-pc'};
opt.m.tex_model = 'pi';
opt.m.alpha = 1.9;

% Train
Train_DS


%% Fitting

% Specify binary DB
opt.bin_root = '..\BinaryDataBases\';
opt.type = 'Test';
opt.name = ['LFPW-' opt.type];
test_db = DB(opt.name,opt.bin_root);

% Specify Fitting DataSet
opt.id = 1:224;
opt.test_reg_exp_query = test_db.RegExpQuery(opt.id);

% Specify Fitting Options
opt.n_it = 200;
opt.n_c = {50,50,50};     % tex

opt.n_p1 = {10,5,3};      % global

opt.n_p2 = {4,4,3};       % mass
opt.n_r = { 3,  2,  1;    % component 1: mouth
            3,  2,  1;    % component 2: nose
            2,  1,  0;    % component 3: left eye
            2,  1,  0;    % component 4: right eye
            3,  2,  1;    % component 5: jaw
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

