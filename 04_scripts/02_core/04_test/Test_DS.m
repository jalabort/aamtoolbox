figure
hold on

% font
font_size = 12;
set(gca,'FontWeight','bold');

% title
title(opt.name,'Interpreter','tex','fontsize',font_size);

% grid
grid on

% axis
ytick = 0:0.1:1;
set(gca, 'ytick', ytick);
ylabel('proportion of images','Interpreter','tex','fontsize',font_size);
switch opt.err_type
  case 'rms'
    xlabel('root mean sqaured error','Interpreter','tex','fontsize', ...
      font_size);
    limit = 10;
    step = 0.1;
    xtick = 0:1:limit;
  case 'p2p'
    xlabel('mean ponit-to-point error','Interpreter','tex','fontsize', ...
      font_size);
    limit = 10;
    step = 0.1;
    xtick = 0:1:limit;
  case 'ram'
    xlabel('mean face-size normalized poit-to-point error', ...
      'Interpreter','tex','fontsize',font_size);
    limit = 0.05;
    step = 0.0005;
    xtick = 0:0.01:limit;
  case 'hel'
    xlabel('mean interocular-distance normalized poit-to-point error', ...
      'Interpreter','tex','fontsize',font_size);
    limit = 0.2;
    step = 0.001;
    xtick = 0:0.02:limit;
end
set(gca, 'xtick', xtick);

% compute error
err = zeros(test_ds.n_data,1);
for i = 1:test_ds.n_data
  [rms_err,p2p_err,ram_err,hel_err] = computeerr(fann(:,:,i), ...
        test_ds.data{i}.ann, ...
        test_ds.data{i}.ann, ...
        test_db.comp);
  switch opt.err_type
    case 'rms'
      err(i) = rms_err;
    case 'p2p'
      err(i) = p2p_err;
    case 'ram'
      err(i) = ram_err;
    case 'hel'
      err(i) = hel_err;
  end
end

% compute cumulative error
list = 0:step:limit;
cerr = zeros(size(list));
count = 1;
for i = list
  cerr(count) = length(find(err < i)) / (test_ds.n_data);
  count = count + 1;
end

plot(list,cerr,opt.symbol,'MarkerSize',2,'linewidth',1);
method = [cell2mat(opt.m.shape_model) ' - ' ...
  cell2mat(opt.m.tex_model) ' - ' ...
  opt.fitter];
legend(method, 'Location', 'SouthEast');

