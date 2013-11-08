%% Load AAM fitter
load('../data_cvpr2014/lfpw_fitter.mat')


%% Options

f.n_it = 50;

% set folder
folder = 'villains';
path = ['..' filesep 'data' filesep folder filesep];
img_type = 'jpg';

% control options
opt.show = true;


%% Fitting

display('- fitting');

% read folder
data = dir([path '*.' img_type]);
n_data = length(data);
fann = zeros(68,2,f.n_it+2,n_fittings);

for i = 1:n_data

  % read image from input file
  img=imread([path data(i).name]);

  [fit] = f.FitSparse(img,[]);
  
  if fit ~= zeros(size(fit))
    fann(:,:,i) = fit(:,:,end);
    
    % show the fitting
    if opt.show
      if all(all(fit(:,:,end)))
        aamshow(1,img,fit,f.w{1}.rf.parts);
        drawnow
      end
    end

    fprintf(['  - img: ' int2str(i) '/' int2str(n_data) '\n']);
     
  end
end