function ResetPriors(obj)
  %ResetPriors Summary of this function goes here
  %   Detailed explanation goes here

  if obj.tex_reg == 2
    for i = 1:obj.n_level
      obj.sigma_ck{i} = obj.tm{i}.variance * obj.tm{i}.pc(:,1:obj.tm{i}.n_c)' * obj.tm{i}.pc(:,1:obj.tm{i}.n_c);
    end
  end
  
  if obj.shape_reg == 2
    for i = 1:obj.n_level
      obj.w{i}.sigma_pk = zeros(size(obj.w{i}.sigma_p0));
    end
  end
    
end

