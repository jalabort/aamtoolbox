display('- loading test dataset');

% load training dataset
[test_ds,loaded] = test_db.Load(opt.reg_exp_query);
assert(loaded,'test dataset could not be loaded!'); 

display('- fitting');

if  opt.noise_scale == 0 || strcmp(opt.detector,'matlab')
  n_fittings = test_ds.n_data;
else
  n_fittings = 25 * test_ds.n_data;
end
fann = zeros(train_db.n_vert,2,n_fittings);

% fitting loop
if opt.parallel
  Fit_Parallel
else
  Fit_Sequential
end

% save fitted ann
if opt.save_ann
  saveann(opt,fann);
end

