clear all
close all
clc


%% Test M_2D

disp('- Test M_2D test');

% specify database
bin_root = ['..' ...
  filesep 'binarydb' ...
  filesep];
name = 'lfpw';
type = 'train';
ann = 'our';
db = DB([name '-' type '-' ann],bin_root);

% number of image
n_data = 811;

% get dataset
id = 1:n_data;
reg_exp_query = db.RegExpQuery(id);
ds = db.Load(reg_exp_query);

% create RF reference frame
ref_ann = ds.ComputeRefAnn(); 
parts = ds.parts; 
erode1 = 1; 
erode2 = 2;
rf = RF(ref_ann,parts,erode1,erode2);

% create W_TPS warper
interp = 'linear';
w = W_TPS(rf,interp);

% create Test GTM_Pi texture model
img = GTM_Pi.ColorTransformAll(w.WarpDS(ds));
smoother = [];
tm = GTM_Pi(img,rf,smoother);

% reconstruct original images
rimg = zeros(size(img));
rec_err = zeros(ds.n_data,1);
for i = 1:ds.n_data
  rimg(:,:,:,i) = tm.ProjectImg(img(:,:,:,i));
  rec_err(i) = mean(sum((img(:,:,:,i) - rimg(:,:,:,i)).^2,2));
end

% visualize model (this just makes sure the model can be correctly 
% visualized, for careful inpection each eigenvector should be plot
% using imshow(tm.Tex2Img(tm.pc(:,i),[]))
figure(1);
imshow(tm.Tex2Img(tm.mu),[]);
h = imshow(tm.Tex2Img(tm.pc(:,1)),[]);
set(h,'EraseMode','none') 
for i = 2:tm.n_pc
  set(h,'CData',tm.Tex2Img(tm.pc(:,i)));
  drawnow;
end

% test
tolerance = 10^-10;
assert( all(rec_err < tolerance*ones(size(rec_err))) && ...
  tm.n_pixels == tm.res(1) * tm.res(2) && ...
  tm.n_pixels>tm.n_face_pixels1 && ...
  tm.n_face_pixels1>tm.n_face_pixels2 && ... 
  tm.n_ch == tm.n_ch_img * tm.n_ch_features && ...
  tm.n_face_features == tm.n_face_pixels1 * tm.n_ch_features && ...
  tm.n_pc == size(tm.pc,2) && ...
  tm.n_pc == tm.n_c)
disp('  passed');