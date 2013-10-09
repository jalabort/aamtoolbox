function writepts(folder_pts,pts_name,points,n_points)

  fid=fopen([folder_pts pts_name(1:end-4),'.pts'],'w');
  fprintf(fid,'version: 1\n');
  fprintf(fid,['n_points:' int2str(n_points) '\n']);
  fprintf(fid,'{\n');
  for p=1:n_points
      fprintf(fid,'%f %f\n',points(p,1),points(p,2)); 
  end
  fprintf(fid,'}');    
  fclose(fid);
  
end