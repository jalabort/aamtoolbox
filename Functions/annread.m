function [ann] = annread(annPath,nVert,w,h)
  %annread Summary of this function goes here
  %   Detailed explanation goes here
  
  [~, ext] = strtok(annPath,'.');

  switch ext
    case '.asf'
      ann = dlmread(annPath, '\t', [16 2 16+nVert-1 3]);
      ann(:,1) = ann(:,1) * w;
      ann(:,2) = ann(:,2) * h;
    case '.pts'
      fid = fopen(annPath);
      tline = fgetl(fid);
      start = 1; 
      while ~strcmp(tline, '{')     
        start = start + 1;
        tline = fgetl(fid);      
      end
      fclose(fid);
      ann =  dlmread(annPath, ' ', [start 0 start+nVert-1 1]);
    case '.txt'
      fid = fopen(annPath);
      fgetl(fid);
      fclose(fid);
      ann =  dlmread(annPath, ',', [1 0 1+nVert-1 1]);
  end
    
end