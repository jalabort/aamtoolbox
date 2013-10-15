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
opt.detector = 'gr-tr';
opt.rotation = false;
opt.noise_scale = 0.00;
opt.composition_interface = {'papandreou'};
opt.shape_reg = 1;
opt.tex_reg = 1;

% build ...F... fitter
Build_F_From_M