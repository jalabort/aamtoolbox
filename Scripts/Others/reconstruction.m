opt.n_p2 = {7,5,3};    % mass
opt.n_r = {4, 3, 1;    % component 1: mouth
           3, 1, 0;    % component 2: nose
           2, 1, 0;    % component 3: left eye
           2, 1, 0;    % component 4: right eye
           4, 2, 1;    % component 5: jaw
           1, 0, 0;    % component 6: left eyebrow
           1, 0, 0};   % component 7: right eyebrow
          

opt.n_p1 = {5,10,0};      % global

for i = 1:f.n_level
%   f.tm{i}.n_c = opt.n_c{i};
%   if strcmp(opt.m.shape_model{i}(1:2),'cb')
%     f.sm{i}.n_p = opt.n_p2{i};
%     f.sm{i}.n_r = [opt.n_r{:,i}];
%     f.sm{i}.n_qpr = f.sm{i}.n_q + opt.n_p2{i} + sum([opt.n_r{:,i}]);
%   else
    f.sm{3}.n_p = 0;
    f.sm{3}.n_qpr = 0;
    
    f.sm{i}.n_p = opt.n_p1{i};
    f.sm{i}.n_qpr = f.sm{i}.n_q  + opt.n_p1{i};
%   end
end

fann = zeros(train_db.n_vert,2,test_ds.n_data);

for i = 1:test_ds.n_data
  
  a = f.sm{1}.ProjectAnn(test_ds.data{i}.ann); 
  fann(:,:,i) = f.sm{1}.ProjectAnn(a); 
  
end

Test_Helen