% fitter options
opt.n_it = 100; 
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
opt.composition_interface = {'baker'};

% build ...F... fitter
Build_F_From_M