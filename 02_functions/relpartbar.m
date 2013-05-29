function relpartbar(test_ds,err_type,fann1,fann2)
  %relpartbar Summary of this function goes here
  %   Detailed explanation goes here

  n = test_ds.n_comp;
  
  % compute part error
  part_err1 = computeparterr(test_ds,err_type,fann1);
  part_err2 = computeparterr(test_ds,err_type,fann2);

  % compute relative improvement
  data = (mean(part_err1,1)-mean(part_err2,1)) ./ mean(part_err1,1);

  % plot bar
  h = bar(1:n,data);
  colormap winter
  ch = get(h,'Children');
  fvd = get(ch,'Faces');
  fvcd = get(ch,'FaceVertexCData');
  k = 128;                
  colormap(winter(k));    
  shading interp          
  for i = 1:n
      color = floor(k*i/n);       
      fvcd(fvd(i,1)) = 1;       
      fvcd(fvd(i,4)) = 1;    
      fvcd(fvd(i,2)) = color;   
      fvcd(fvd(i,3)) = color;
  end
  set(ch,'FaceVertexCData', fvcd);
  set(ch,'EdgeColor','k');  
  
end