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
opt.m.warp = 'pwa';
opt.m.interp = 'bilinear';
opt.m.smoothing = 'none';
opt.m.g_type = 'CentralDifference';
opt.m.sigma = {1,2,3};
opt.m.shape_model = {'pc','pc','pc'};
opt.m.tex_model = 'igo-double';
opt.m.alpha = 1.99;

% Train
Train_DS


%% Fitting

% Specify binary DB
opt.bin_root = '../BinaryDataBases/';
opt.type = 'Test';
opt.name = ['LFPW-' opt.type];
test_db = DB(opt.name,opt.bin_root);

% Specify Fitting DataSet
opt.id = 1:224;
opt.test_reg_exp_query = test_db.RegExpQuery(opt.id);

% Specify Fitting Options
opt.n_it = 100;
opt.n_c = {50,50,50};  % tex

opt.n_p1 = {12,6,3};    % global
          
opt.face_detector = 'matlab';
opt.algorithm = 'aic-ssd';
opt.composition = 'baker';

% Specify Control Options
opt.show_fitting = true;
opt.show_error = false;

% Fit
Fit_DS
Test

