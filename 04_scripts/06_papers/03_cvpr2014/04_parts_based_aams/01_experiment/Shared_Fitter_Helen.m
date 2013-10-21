% fitter options
opt.n_it = 200; 
opt.n_c = ... % # of appearance eigenvectors
  {300, ...
   200, ...
   100};  
opt.fitter = 'asc-ssd';
opt.detector = 'gr-tr';
opt.rotation = false;
opt.noise_scale = 0.00;
opt.composition_interface = {'papandreou'};
opt.shape_reg = 0;
opt.tex_reg = 0;

% build ...F... fitter
Build_F_From_M