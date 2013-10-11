display('- building fitter');

if m.n_level == length(opt.m.tex_model)
  Lp = opt.m.Lp{i};
else
  Lp = cell2mat(opt.m.Lp);
end

% build ...F... fitter
clear f
switch opt.fitter
  % project-out -----------------------------------------------------------
  % project-out-forward-compositional
  case 'pfc-ssd'
    f = F_Pfc_Ssd(m);
  % project-out-inverse-compositional
  case 'pic-ssd'
    f = F_Pic_Ssd(m);
  case 'pic-ecc'
    f = F_Pic_Ecc(m);
  % project-out-symmetric-compositional
  case 'psc-ssd'
    f = F_Psc_Ssd(m);
  % project-out-bidirectional-compositional
  case 'pbc-ssd'
    f = F_Pbc_Ssd(m);
  % alternating -----------------------------------------------------------
  % alternating-forward-compositional
  case 'afc-ssd'
    f = F_Afc_Ssd(m);
  % alternating-inverse-compositional
  case 'aic-ssd'
    f = F_Aic_Ssd(m);
  case 'aic-ecc'
    f = F_Aic_Ecc(m);
  case 'aic-lp'
    f = F_Aic_Lp(m,Lp);
  % alternating-symmetric-compositional 
  case 'asc-ssd'
    f = F_Asc_Ssd(m);
  % alternating-bidirectional-compositional
  case 'abc-ssd'
    f = F_Abc_Ssd(m);
  % adaptive --------------------------------------------------------------
  % adaptative-inverse-compositional
  case 'cic-ssd'
    f = F_Cic_Ssd(m);
  case 'cic-ecc'
    f = F_Cic_Ecc(m);
  % simultaneous ----------------------------------------------------------
  % simultaneous-inverse-compositional
  case 'sic-ssd'
    f = F_Sic_Ssd(m);
  case 'sic-ecc'
    f = F_Sic_Ecc(m);
  % probabilistic ---------------------------------------------------------
  % probabilistic-foward-additive
  case 'p-fa-dts'
    f = PF_Fa_DtS(m);
  case 'p-fa-dws'
    f = PF_Fa_DwS(m);
  case 'p-fa-dts-dws'
    f = PF_Fa_DtS_DwS(m);
  % probabilistic-forward-compositional
  case 'p-fc-dts'
    f = PF_Fc_DtS(m);
  case 'p-fc-dws'
    f = PF_Fc_DwS(m);
  case 'p-fc-dts-dws'
    f = PF_Fc_DtS_DwS(m);
  % probabilistic-inverse-compositional
  case 'p-ic-dts'
    f = PF_Ic_DtS(m);
  case 'p-ic-dws'
    f = PF_Ic_DwS(m);
  case 'p-ic-dts-dws'
    f = PF_Ic_DtS_DwS(m);
end
assert(isa(f,'F_2D') ,'undifiened fitter!');

% build ...FD... face detector
switch opt.detector 
  case 'gr-tr'
    f.detector = FD_GrTr(opt.rotation, opt.noise_scale);
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
  [f.tm{i}.n_c,f.tm{i}.variance] = f.tm{i}.SetNC(n_c);
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
if opt.m.dense
  f = f.InitializeDense();
else
  f = f.InitializeSparse();
end

