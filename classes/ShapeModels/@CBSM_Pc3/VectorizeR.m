function [vec_r] = VectorizeR(obj,r)
  %VECTORIZER Summary of this function goes here
  %   Detailed explanation goes here

  vec_r = [];
  for i = 1:obj.n_comp
    vec_r = [vec_r;r{i}];
  end
end

