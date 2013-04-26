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
opt.m.erode = 1;
opt.m.warp = 'pwa';
opt.m.interp = 'bilinear';
opt.m.smoothing = 'none';
opt.m.g_type = 'CentralDifference';
opt.m.sigma = {1,1,1};
opt.m.shape_model = {'pc2','pc2','pc2'};
opt.m.tex_model = 'pi';
opt.m.alpha = 1.99;

% Train
Train_DS


%% Fitting

% Specify binary DB
opt.bin_root = '../BinaryDataBases/';
opt.type = 'Test-Original';
opt.name = ['HelenRescaled-' opt.type];
test_db = DB(opt.name,opt.bin_root);

% Specify Fitting DataSet
opt.id = 1:330;
opt.test_reg_exp_query = test_db.RegExpQuery(opt.id);

% Specify Fitting Options
opt.n_it = 100;
opt.n_c = {200,100,50};     % tex

opt.n_p1 = {20,10,5};      % global
          
opt.face_detector = 'gr-tr';
opt.algorithm = 'aic-ssd';
opt.composition = 'baker';

opt.n_bin = {8,8,8};   % df
opt.sigma = {1,1,1};

% Specify Control Options
opt.show_fitting = false;
opt.show_error = true;

% Fit
Fit_DS


%% Test

Test_Helen
