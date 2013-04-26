% Load Shapes

pathA = '../AnnotatedFaceImageDataBases/Helen/TrainAnnotations/Original/';

list = dir([pathA '*.txt']);
n_ann = length(list);
n_vert = 194;

ann = zeros(n_vert,2,n_ann);

for i = 1:n_ann
  
  ann(:,:,i) = annread([pathA list(i).name],n_vert);
  
end


% Procrustes

cent_ann = ann - repmat(mean(ann,1),[n_vert 1 1]);
  
mean_cent_ann = mean(cent_ann,3);
div_err = 1; e = 1e-20; it = 1; max_it = 100;
while div_err >= e && it <= max_it 
  for i = 1:n_ann       
    [~,cent_ann(:,:,i)] = procrustes(mean_cent_ann,cent_ann(:,:,i));
  end
  new_mean_cent_ann = mean(cent_ann,3);
  [div_err,mean_cent_ann] = procrustes(mean_cent_ann,new_mean_cent_ann);
  it = it + 1;  
end

pathD = '../AnnotatedFaceImageDataBases/Helen/TestAnnotations/Original/';

list = dir([pathD '*.txt']);
n_ann = length(list);
n_vert = 194;

ann = zeros(n_vert,2,n_ann);

for i = 1:n_ann
  
  ann(:,:,i) = annread([pathD list(i).name],n_vert);
  
end

% Yorgos part

pathB = '../AnnotatedFaceImageDataBases/Helen/TestImages/';
listB = dir([pathB '*.jpg']);

pathC = '../AnnotatedFaceImageDataBases/HelenRescaled/TestImages/';
pathD = '../AnnotatedFaceImageDataBases/HelenRescaled/TestAnnotations/Original/';

for i = 1:n_ann
  
    input_image = imread([pathB listB(i).name]);

  current_shape = ann(:,:,i);
  mean_shape = new_mean_cent_ann/4;
  [D, ZZ, T] = procrustes(mean_shape, current_shape, 'Reflection', false);
  scl = T.b;
 input_image = imresize(input_image, scl);
  current_shape = scl*ann(:,:,i);
  
  imwrite(input_image,[pathC listB(i).name],'JPG');
  
  writepts(pathD,list(i).name,current_shape,n_vert);
   
  i

end