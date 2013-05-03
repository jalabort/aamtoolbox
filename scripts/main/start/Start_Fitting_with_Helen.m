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
opt.m.sigma = {1,1,1};
opt.m.shape_model = {'pc','pc','pc'};
opt.m.tex_model = 'pi';
opt.m.alpha = 1.99;

% Train
Train_DS


%% Tracking

% Specify folder & sequence
opt.folder = '../Tracking/Sequences/';
opt.sequence = 'TheDarkKnight/n8/';
opt.img_ext = '.png';

% Specify Fitting Options
opt.n_it = 100;
opt.n_c = {100,100,100};     % tex

opt.n_p1 = {12,6,3};      % global

opt.n_p2 = {5,3,2};       % mass
opt.n_r = { 4,  3,  1;    % component 1: mouth
            3,  2,  1;    % component 2: nose
            2,  1,  0;    % component 3: left eye
            2,  1,  0;    % component 4: right eye
            4,  2,  2;    % component 5: jaw
            2,  0,  0;    % component 6: left eyebrow
            2,  0,  0};   % component 7: right eyebrow
opt.reg = false;
opt.weight = {0.01,0.01,0.01};
opt.face_detector = 'matlab';
opt.algorithm = 'aic-ecc';
opt.composition = 'baker';

% Specify Control Options
opt.show_fitting = true;
opt.show_error = false;
opt.save_img = true;

% Track
Fit_Sequence

