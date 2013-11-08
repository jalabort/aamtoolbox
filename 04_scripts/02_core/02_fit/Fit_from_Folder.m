display('- fitting');

if  opt.noise_scale == 0 || strcmp(opt.detector,'matlab')
  n_rand = 1;
  n_fittings = test_db.n_data;
else
  n_rand = 1;
  n_fittings = n_rand * test_db.n_data;
end
fann = zeros(train_db.n_vert,2,opt.n_it+2,n_fittings);
iann = zeros(train_db.n_vert,2,n_fittings);
oann = iann;

% read folder
data = dir([path '*.' test_db.img_type]);
% read folder
data2 = dir([path '*.' test_db.ann_type]);

% fitting loop
if opt.parallel
  Fit_Parallel_from_Folder
else
  Fit_Sequential_from_Folder
end

% save fitted ann
if opt.save_ann
  saveann(opt,fann);
end

