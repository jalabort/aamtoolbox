% fitter options
opt.n_it = 50; 
opt.n_c = ... % # of appearance eigenvectors
  {50, ...
   50, ...
   50}; 
opt.n_b = ... % # of shape eigenvectors 
  {12, ...
   6, ...
   3};   
opt.fitter = 'aic-ecc';
opt.detector = 'gr-tr';
opt.rotation = false;
opt.composition_interface = {'papandreou'};

% build ...F... fitter
Build_F_From_M