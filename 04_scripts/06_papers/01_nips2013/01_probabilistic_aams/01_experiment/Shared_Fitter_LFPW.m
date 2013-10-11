% fitter options
opt.n_it = 50; 
opt.n_c = ... % # of appearance eigenvectors
  {200, ...
   200, ...
   200}; 
opt.n_b = ... % # of shape eigenvectors 
  {12, ...
   6, ...
   3};   
opt.detector = 'gr-tr';
opt.rotation = false;
opt.noise_scale = 0.00;
opt.composition_interface = {'papandreou'};

% build ...F... fitter
Build_F_From_M