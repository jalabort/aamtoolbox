function [rms_err,p2p_err,ram_err,hel_err]= computeerr(fann,ann,comp)
  %computeerr Summary of this function goes here
  %   Detailed explanation goes here
  
  % rms_err
  rms_err = sqrt(mean((ann(:) - fann(:)).^2));

  % p2p_err
  p2p_err = mean(sqrt(sum((ann- fann).^2,2)));
  
  % ram_err
  face_size = mean(max(ann) - min(ann));
  ram_err = p2p_err / face_size;
  
  % hel_err
  eye1 = mean(ann(comp{3},:));
  eye2 = mean(ann(comp{4},:));
  eye_dist = mean(sqrt(sum((eye1 - eye2).^2,2)));
  hel_err = p2p_err / eye_dist;

end

