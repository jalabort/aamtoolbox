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
opt.detector = 'matlab';
opt.rotation = true;
opt.composition_interface = {'baker'};

% build ...F... fitter
Build_F_From_M