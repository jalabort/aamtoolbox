% fitter options
opt.n_it = 50; 
opt.n_c = ... % # of appearance eigenvectors
  {15, ...
   15, ...
   15}; 
opt.n_b = ... % # of shape eigenvectors 
  {15, ...
   10, ...
   5};   
opt.detector = 'matlab';
opt.rotation = false;
opt.noise_scale = 0;
opt.composition_interface = {'baker'};
opt.shape_reg = 0;
opt.tex_reg = 0;

% build ...F... fitter
Build_F_From_M