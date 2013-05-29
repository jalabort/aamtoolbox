% fitter options
opt.n_it = 50; 
opt.n_c = ... % # of appearance eigenvectors
  {200, ...
   100, ...
   50};    
opt.fitter = 'aic-ssd';
opt.detector = 'gr-tr';
opt.rotation = false;
opt.composition_interface = {'baker'};

% build ...F... fitter
Build_F_From_M