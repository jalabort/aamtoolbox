function Build(obj,scale,img_path,ann_path,img_type,ann_type,n_vert,n_ch)
  %BUILD Summary of this function goes here
  %   Detailed explanation goes here

  assert(exist(img_path,'dir')==7,'Specified image directory does not exist\n');
  assert(exist(ann_path,'dir')==7,'Specified annotation directory does not exist\n');
  img_list = dir([img_path '*.' img_type]);
  ann_list = dir([ann_path '*.' ann_type]);
  n_img = length(img_list);
  n_ann = length(ann_list);
  
  assert(n_img == n_ann,'Number of image and annotation files in DataBase must be related\n');
  
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
  assert(exist([ann_path 'tri.mat'],'file')==2,'Could not find tri.mat in');
  load([ann_path 'tri.mat']);
  obj.tri = tri;
  obj.n_tri = length(obj.tri);
  assert(exist([ann_path 'comp.mat'],'file')==2,'Could not find comp.mat in');
  load([ann_path 'comp.mat']);
  obj.comp = comp;
  obj.n_comp = length(obj.comp);
  assert(exist([ann_path 'parts.mat'],'file')==2,'Could not find parts.mat in');
  load([ann_path 'parts.mat']);
  obj.parts = parts;
  obj.n_parts = length(obj.parts);
  assert(exist([ann_path 'list.mat'],'file')==2,'Could not find lists.mat in');
  load([obj.ann_path 'list.mat']);
  obj.list = list;
  
  save(obj.bin_path,'obj');
  
  try
  
    h = waitbar(0,sprintf('Building %s DataBase',obj.name));
    struct_name = cell(n_ann,1);

    for i = 1:n_ann

      img_name = strtok(img_list(i).name,'.');

      img = imread([img_path img_list(i).name]);
      img =  imresize(img,scale);
      
      ann = annread([ann_path ann_list(i).name], n_vert);
      ann =  ann .* scale;

      struct_name{i} = ['x' img_name];
      eval(sprintf([struct_name{i} '.img = img;']));
      eval(sprintf([struct_name{i} '.ann = ann;'])); 

      waitbar(i/n_img,h); 

    end
    
    clear  ann_list ann_path ann_type comp img_list img_path img_type ... 
           list n_ann n_ch n_img n_vert parts scale tri i struct_name ...
           img_name img ann 
    
    close(h);
    
    save(obj.bin_path)
    
  catch err;
    
    delete(obj.bin_path);
    close(h);
    rethrow(exception);
    
  end
  
end