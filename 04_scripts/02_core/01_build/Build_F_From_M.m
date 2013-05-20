display('- building fitter');

% build ...F... fitter
switch opt.fitter
  case 'pic-ssd'
    f = F_Pic_Ssd(m);
  case 'pic-ecc'
    f = F_Pic_Ecc(m);
  case 'aic-ssd'
    f = F_Aic_Ssd(m);
  case 'aic-ecc'
    f = F_Aic_Ecc(m);
  case 'sic-ssd'
    f = F_Sic_Ssd(m);
  case 'sic-ecc'
    f = F_Sic_Ecc(m);
end
assert(isa(f,'F_2D') ,'undifiened fitter!');
clear m

% build ...FD... face detector
switch opt.detector 
  case 'gr-tr'
    f.detector = FD_GrTr(opt.rotation);
  case 'matlab'
    f.detector = FD_Mat(opt.rotation);
end
assert(isa(f.detector,'FD') ,'undifiened face detector!');

% set # of iterations
f.n_it = opt.n_it;

% set per level options
for i = 1:f.n_level

  % set baker or papandreou composition interfaces
  if f.n_level == length(opt.composition)
    composition = opt.composition{i};
  else
    composition = cell2mat(opt.composition);
  end
  switch composition 
    case 'baker'
      f.w{i} = W_PWA_Baker(f.w{i});
    case 'papandreou'
      f.w{i} = W_PWA_Papandreou(f.w{i});
  end
  assert(isa(f.w{i},'iC') ,'undifiened composition interface!');

  % set appearance model size
  if f.n_level == length(opt.n_c)
    n_c = opt.n_c{i};
  else
    n_c = cell2mat(opt.n_c);
  end
  f.tm{i}.n_c = n_c;
  assert(f.tm{i}.n_c <= f.tm{i}.n_pc, ...
    '# of appearance eigenvectors is too large');

  % set shape model size
  if isa(f.sm{i},'GSM') 
    % global shape model
    if f.n_level == length(opt.n_b)
      n_b = opt.n_b{i};
    else
      n_b = cell2mat(opt.n_b);
    end
    [f.sm{i}.n_b,f.sm{i}.n_p] = f.sm{i}.SetNB(n_b);
    assert(f.sm{i}.n_b <= f.sm{i}.n_pc, ... 
      '# of shape eigenvectors is too large');
  elseif isa(f.sm{i},'CSM') 
    % component shape model
    if f.n_level == length(opt.n_b)
      n_b = opt.n_b{i};
    else
      n_b = cell2mat(opt.n_b);
    end
    [f.sm{i}.n_b,f.sm{i}.n_p] = f.sm{i}.SetNB(opt.n_b);
    assert(f.sm{i}.n_b <= f.sm{i}.n_mass_pc, ...
      '# of mass shape eigenvectors is too large');
    if f.n_level == length(opt.n_r)
      n_r = opt.n_r{i};
    else
      n_r = cell2mat(opt.n_r);
    end
    [f.sm{i}.n_r,f.sm{i}.n_p] = f.sm{i}.SetNR(n_r);
    assert(all(cell2mat(f.sm{i}.n_r) <= ...
      cell2mat(f.sm{i}.n_comp_pc)), ...
      '# of comp shape eigenvectors is too large'); 
  elseif isa(f.sm{i},'PSM') 
    % part shape model
    if f.n_level == length(opt.n_l)
      n_l = opt.n_l{i};
    else
      n_l = cell2mat(opt.n_l);
    end
    [f.sm{i}.n_l,f.sm{i}.n_p] = f.sm{i}.SetNB(n_l);
    assert(f.sm{i}.n_l <= f.sm{i}.n_pose_pc, ...
      '# of pose shape eigenvectors is too large');
    if f.n_level == length(opt.n_b)
      n_b = opt.n_b{i};
    else
      n_b = cell2mat(opt.n_b);
    end
    [f.sm{i}.n_b,f.sm{i}.n_p] = f.sm{i}.SetNB(n_b);
    assert(f.sm{i}.n_b <= f.sm{i}.n_mass_pc, ...
      '# of mass shape eigenvectors is too large');
    if f.n_level == size(opt.n_r,2)
      n_r = opt.n_r{:,i};
    else
      n_r = cell2mat(opt.n_r);
    end
    [f.sm{i}.n_r,f.sm{i}.n_p] = f.sm{i}.SetNR(n_r);
    assert(all(cell2mat(f.sm{i}.n_r) <= ...
      cell2mat(f.sm{i}.n_part_pc)), ...
      '# of part shape eigenvectors is too large'); 
  end

end

clear loaded i composition n_c n_b

display('- initializing fitter');

% initialize fitter
f = f.Initialize();

