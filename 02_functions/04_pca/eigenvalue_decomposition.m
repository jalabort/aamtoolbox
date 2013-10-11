function [pos_evec, pos_eval] = eigenvalue_decomposition(S)

  % compute eigenvalue decomposition
  [evec, eval] = eig(S);
  eval = diag(eval)';

  % sort eigenvalues from largest to smallest
  [eval, index] = sort(eval);
  eval = fliplr(eval);
  evec = fliplr(evec(:,index));

  % set tolerance limit
  eps = 10^-12;
  limit = max(max(abs(eval)) * eps); 

  % select positive eigenvalues
  index_pos = find(eval > 0);
  pos_evec = evec(:,index_pos);
  pos_eval = eval(index_pos);
  % check they are within the expected tolerance
  index              = find(pos_eval > limit);
  pos_eval           = pos_eval(index);
  pos_evec           = pos_evec(:,index);

end