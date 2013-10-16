% fitter options
opt.n_it = 100; 
opt.n_c = ... % # of appearance eigenvectors
  {50, ...
   50, ...
   50}; 
opt.n_b = ... % # of shape eigenvectors 
  {5, ...
   4, ...
   3};   
opt.detector = 'gr-tr';
opt.rotation = false;
opt.noise_scale = 0.00;
opt.composition_interface = {'papandreou'};
opt.shape_reg = 0;
opt.tex_reg = 0;

% build ...F... fitter
Build_F_From_M