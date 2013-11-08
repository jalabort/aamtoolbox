%% Load AAM fitter
load('../data/lfpw_fitter.mat')


%% Options

% set folder
folder = '0681_01_012_gloria_estefan';
path = ['..' filesep 'data' filesep folder filesep];
img_type = 'png';

% control options
opt.show = true;


%% Tracking

display('- fitting');

% read folder
data = dir([path '*.' img_type]);
n_fittings = length(data);
fann = zeros(train_db.n_vert,2,opt.n_it+2,n_fittings);
ini = [];

for i = 1:n_fittings

  j = floor((i-1)/n_rand) + 1;

  % read image from input file
  img = imread([path data(j).name]);

  [fit] = f.TrackSparse(img,ini);
  
  if fit ~= zeros(size(fit))
    fann(:,:,i) = fit(:,:,end);
    ini = fit(:,:,end);
    
    % show the fitting
    if opt.show
      if all(all(fit(:,:,end)))
        aamshow(1,img,fit,test_db.parts);
        drawnow
      end
    end

    fprintf(['  - img: ' int2str(j) '/' int2str(test_db.n_data) '\n']);
     
  end
end