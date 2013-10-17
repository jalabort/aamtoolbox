function Build(obj,scale,img_path,ann_path,img_type,ann_type,n_vert,n_ch)
  %Build Summary of this function goes here
  %   Detailed explanation goes here

  assert(exist(img_path,'dir')==7, ...
    'image directory does not exist\n');
  assert(exist(ann_path,'dir')==7,...
    'annotation directory does not exist\n');
  img_list = dir([img_path '*.' img_type]);
  ann_list = dir([ann_path '*.' ann_type]);
  n_img = length(img_list);
  n_ann = length(ann_list);
  
  assert(n_img == n_ann, ... 
    '# image and annotation files in db must be related\n');
  
  if exist(obj.bin_path,'file')
    delete(obj.bin_path);
  end
  
  obj.scale = scale;
  obj.img_path = img_path;
  obj.ann_path = ann_path;
  obj.img_type = img_type;
  obj.ann_type = ann_type;
  obj.n_vert = n_vert;
  obj.n_ch = n_ch;
  obj.n_data = n_ann;
  
  [~,aux_path] = strtok(fliplr(ann_path),filesep);
  aux_path = fliplr(aux_path);
  assert(exist([aux_path 'tri.mat'],'file')==2,'tri.mat not found');
  load([aux_path 'tri.mat']);
  obj.tri = tri;
  obj.n_tri = length(obj.tri);
  assert(exist([aux_path 'comp.mat'],'file')==2,'comp.mat not found');
  load([aux_path 'comp.mat']);
  obj.comp = comp;
  obj.n_comp = length(obj.comp);
  assert(exist([aux_path 'parts.mat'],'file')==2,'parts.mat not found');
  load([aux_path 'parts.mat']);
  obj.parts = parts;
  obj.n_parts = length(obj.parts);
  
  assert(exist([ann_path 'list.mat'],'file')==2,'lists.mat  not found');
  load([ann_path 'list.mat']);
  obj.list = list;
  
  save(obj.bin_path,'obj');
  
  %try
  
    h = waitbar(0,sprintf('building binary db %s',obj.name));
    struct_name = cell(n_ann,1);

    for i = 1:n_ann

      [~,img_name] = fileparts([img_path img_list(i).name]);

      img = double(imread([img_path img_list(i).name])) / 255;
      if scale ~= 1
        img = imresize(img,scale);
      end
      
      ann = annread([ann_path ann_list(i).name], n_vert);
      ann = ann .* scale;

      struct_name{i} = ['x' obj.list.id{i}];
      eval(sprintf([struct_name{i} '.img = img;']));
      eval(sprintf([struct_name{i} '.ann = ann;'])); 

      waitbar(i/n_img,h); 

    end
    
    clear  ann_list ann_path ann_type comp img_list img_path img_type ... 
           list n_ann n_ch n_img n_vert parts scale tri i struct_name ...
           img_name img ann 
    
    close(h);
    
    save(obj.bin_path)
    
%   %catch err;
%     
%     delete(obj.bin_path);
%     close(h);
%     rethrow(exception);
%     
%   end
  
end