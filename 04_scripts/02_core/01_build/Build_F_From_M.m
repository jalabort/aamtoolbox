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
  if f.n_level == length(opt.composition_interface)
    composition_interface = opt.composition_interface{i};
  else
    composition_interface = cell2mat(opt.composition_interface);
  end
  switch composition_interface 
    case 'baker'
      if isa(f.w{i},'W_PWA')
        f.w{i} = W_PWA_Baker(f.w{i});
      else
        f.w{i} = W_TPS_Baker(f.w{i});
      end
    case 'papandreou'
      if isa(f.w{i},'W_PWA')
        f.w{i} = W_PWA_Papandreou(f.w{i});
      else
        f.w{i} = W_TPS_Papandreou(f.w{i});
      end
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
  if isa(f.sm{i},'GSM') || isa(f.sm{i},'GSM_Euler') 
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
    if f.n_level == length(opt.n_f)
      n_f = opt.n_f{i};
    else
      n_f = cell2mat(opt.n_f);
    end
    [f.sm{i}.n_f,f.sm{i}.n_b,f.sm{i}.n_p] = f.sm{i}.SetNF(n_f);
    assert(f.sm{i}.n_f <= f.sm{i}.n_mass_pc, ...
      '# of mass shape eigenvectors is too large');
    if f.n_level == size(opt.n_r,2)
      n_r = cell2mat(opt.n_r(:,i));
    else
      n_r = cell2mat(opt.n_r);
    end
    [f.sm{i}.n_r,f.sm{i}.n_b,f.sm{i}.n_p] = f.sm{i}.SetNR(n_r);
    assert(all(f.sm{i}.n_r <= ...
      cell2mat(f.sm{i}.n_part_pc)'), ...
      '# of comp shape eigenvectors is too large'); 
  elseif isa(f.sm{i},'PSM') 
    % part shape model
    if f.n_level == length(opt.n_f)
      n_f = opt.n_f{i};
    else
      n_f = cell2mat(opt.n_f);
    end
    [f.sm{i}.n_f,f.sm{i}.n_b,f.sm{i}.n_p] = f.sm{i}.SetNF(n_f);
    assert(f.sm{i}.n_f <= f.sm{i}.n_mass_pc, ...
      '# of mass shape eigenvectors is too large');
    if f.n_level == size(opt.n_r,2)
      n_r = cell2mat(opt.n_r(:,i));
    else
      n_r = cell2mat(opt.n_r);
    end
    [f.sm{i}.n_r,f.sm{i}.n_b,f.sm{i}.n_p] = f.sm{i}.SetNR(n_r);
    assert(all(f.sm{i}.n_r <= ...
      cell2mat(f.sm{i}.n_part_pc)'), ...
      '# of comp shape eigenvectors is too large'); 
  end
  
  if isa(f.sm{i},'iConcat') 
    [f.sm{i}.U,f.sm{i}.PU] = f.sm{i}.ConstructConcatBasis();
  end

end

clear loaded m i composition_interface n_c n_b

display('- initializing fitter');

% initialize fitter
f = f.Initialize();

