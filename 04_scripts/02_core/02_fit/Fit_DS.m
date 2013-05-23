display('- loading test dataset');

% load training dataset
[test_ds,loaded] = test_db.Load(opt.reg_exp_query);
assert(loaded,'test dataset could not be loaded!'); 

display('- fitting');

fann = zeros(train_db.n_vert,2,test_ds.n_data);

% fitting loop
if opt.parallel
  Fit_Parallel
else
  Fit_Sequential
end

