clear all
close all
clc


%% Test GSM_Euler_Real_Concat

disp('- GSM_Euler_Real_Concat test');

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

% create GSM_Euler_Real_Concat shape model
ann = ds.GetAnn();
alpha = 0.5;
sm = GSM_Euler_Real_NWarp(ann,alpha);

% reconstruct original shapes
rann = zeros(size(ann));
rec_err = zeros(ds.n_data,1);
for i = 1:ds.n_data
  rann(:,:,i) = sm.ProjectAnn(ann(:,:,i));
  rec_err(i) = mean(sum((ann(:,:,i) - rann(:,:,i)).^2,2));
end

% % get dataset
% n_data2 = 200;
% id = n_data:n_data2;
% reg_exp_query = db.RegExpQuery(id);
% ds = db.Load(reg_exp_query);
% 
% % test data
% tann = ds.GetAnn();
% 
% % reconstruct test shapes
% rann = zeros(size(ann));
% rec_err = zeros(ds.n_data,1);
% for i = 1:ds.n_data
%   rann(:,:,i) = sm.ProjectAnn(tann(:,:,i));
%   rec_err(i) = mean(sum((ann(:,:,i) - rann(:,:,i)).^2,2));
% end

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
assert( all(rec_err < tolerance*ones(size(rec_err))) && ...
  sm.n_vert == size(sm.mu_ann,1) && ...
  sm.n_vert == ds.n_vert && ...
  sm.n_pc == size(sm.pc,2) && ...
  sm.n_pc == sm.n_b && ...
  sm.n_sim_basis == size(sm.sim_basis,2) && ...
  sm.n_sim_basis == sm.n_q && ...
  sm.n_pc + sm.n_sim_basis == sm.n_p)
disp('  passed');


%% Test GSM_Euler_Real_NWarp

disp('- GSM_Euler_Real_NWarp test');

% create GSM_Euler_Real_NWarp shape model
ann = ds.GetAnn();
sm = GSM_Euler_Real_NWarp(ann);

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
tolerance1 = 10^-10;
tolerance2 = 10^-10;
U = [sm.sim_basis,sm.pc];
assert(max(max(abs(U'*U - eye(sm.n_p)))) < tolerance1 && ...
  all(rec_err < tolerance2*ones(size(rec_err))) && ...
  sm.n_vert == size(sm.mu_ann,1) && ...
  sm.n_vert == ds.n_vert && ...
  sm.n_pc == size(sm.pc,2) && ...
  sm.n_pc == sm.n_b && ...
  sm.n_sim_basis == size(sm.sim_basis,2) && ...
  sm.n_sim_basis == sm.n_q && ...
  sm.n_pc + sm.n_sim_basis == sm.n_p)
disp('  passed');

