display('- loading test dataset');

% load training dataset
[test_ds,loaded] = test_db.Load(opt.reg_exp_query);
assert(loaded,'test dataset could not be loaded!'); 

display('- fitting');

rann = zeros(train_db.n_vert,2,f.n_level,test_ds.n_data);

% fitting loop
if opt.parallel
  Reconstruct_Parallel
else
  Reconstruct_Sequential
end

