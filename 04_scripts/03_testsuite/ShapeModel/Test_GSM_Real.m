%clear all
close all
clc


%% Test GSM_Real_Concat

disp('- GSM_Real_Concat test');

% specify database
bin_root = ['..' ...
  filesep 'binarydb' ...
  filesep];
name = 'lfpw';
type = 'train';
ann = 'our';
db = DB([name '-' type '-' ann],bin_root);

% number of image
n_data = 100;

% get dataset
id = 1:n_data;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

% create GSM_Real_Concat shape model
ann = ds.GetAnn();
sm = GSM_Real_Concat(ann);

% reconstruct original shapes
rann = zeros(size(ann));
rec_err = zeros(ds.n_data,1);
for i = 1:ds.n_data
  rann(:,:,i) = sm.ProjectAnn(ann(:,:,i));
  rec_err(i) = mean(sum((ann(:,:,i) - rann(:,:,i)).^2,2));
end

% show originals and reconstructions
ori_color = 'green';
rec_color = 'red';
figure(1); 
for i = 1:ds.n_data
  clf
  hold on
  plot(ann(:,1,i),-ann(:,2,i), ...
  '*-', ...
  'Color',ori_color, ...
  'MarkerFaceColor',ori_color, ...
  'MarkerEdgeColor',ori_color, ... 
  'MarkerSize',4);
  plot(rann(:,1,i),-rann(:,2,i), ...
  '*-', ...
  'Color',rec_color, ...
  'MarkerFaceColor',rec_color, ...
  'MarkerEdgeColor',rec_color, ... 
  'MarkerSize',4);
  drawnow;
end

% test
tolerance = 2;
assert( all(rec_err < tolerance*ones(size(rec_err))))
disp('  passed');


%% Test GSM_Real_NWarp

disp('- GSM_Real_NWarp test');

% specify database
bin_root = ['..' ...
  filesep 'binarydb' ...
  filesep];
name = 'lfpw';
type = 'train';
ann = 'our';
db = DB([name '-' type '-' ann],bin_root);

% number of image
n_data = 100;

% get dataset
id = 1:n_data;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

% create GSM_Real_NWarp shape model
ann = ds.GetAnn();
sm = GSM_Real_NWarp(ann);

U = [sm.sim_basis,sm.pc];

% reconstruct original shapes
rann = zeros(size(ann));
rec_err = zeros(ds.n_data,1);
for i = 1:ds.n_data
  rann(:,:,i) = sm.ProjectAnn(ann(:,:,i));

  %rann(:,:,i) = sm.Shape2Ann(U*U'*sm.Ann2Shape(ann(:,:,i)));
  
  
  rec_err(i) = mean(sum((ann(:,:,i) - rann(:,:,i)).^2,2));
end

% show originals and reconstructions
ori_color = 'green';
rec_color = 'red';
figure(1); 
for i = 1:ds.n_data
  clf
  hold on
  plot(ann(:,1,i),-ann(:,2,i), ...
  '*-', ...
  'Color',ori_color, ...
  'MarkerFaceColor',ori_color, ...
  'MarkerEdgeColor',ori_color, ... 
  'MarkerSize',4);
  plot(rann(:,1,i),-rann(:,2,i), ...
  '*-', ...
  'Color',rec_color, ...
  'MarkerFaceColor',rec_color, ...
  'MarkerEdgeColor',rec_color, ... 
  'MarkerSize',4);
  drawnow;
end

% test
tolerance1 = 10^-10;
tolerance2 = 2;
U = [sm.sim_basis,sm.pc];
assert(max(max(abs(U'*U - eye(sm.n_p)))) < tolerance1 && ...
  all(rec_err < tolerance2*ones(size(rec_err))))
disp('  passed');



