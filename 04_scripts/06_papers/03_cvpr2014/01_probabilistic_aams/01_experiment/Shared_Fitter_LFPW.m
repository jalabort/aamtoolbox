% fitter options
opt.n_it = 50; 
opt.n_c = ... % # of appearance eigenvectors
  {100, ...
   100, ...
   100}; 
opt.n_b = ... % # of shape eigenvectors 
  {12, ...
   6, ...
   3};   
opt.detector = 'gr-tr';
opt.rotation = false;
opt.noise_scale = 2;
opt.composition_interface = {'baker'};
opt.shape_reg = 0;
opt.tex_reg = 0;

% build ...F... fitter
Build_F_From_M