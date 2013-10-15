% fitter options
opt.n_it = 150; 
opt.n_c = ... % # of appearance eigenvectors
  {150}; 
opt.n_b = ... % # of shape eigenvectors 
  {10};   
opt.detector = 'gr-tr';
opt.rotation = false;
opt.noise_scale = 0.05;
opt.composition_interface = {'papandreou'};

% build ...F... fitter
Build_F_From_M