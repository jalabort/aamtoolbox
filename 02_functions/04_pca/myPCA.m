function [U, eval]= myPCA(X, whiten, bias, wheight)

  n_features = size(X, 1);
  n_samples = size(X, 2);
  
  if bias
    N = n_samples;
  else
    N = n_samples - 1;
  end

  if n_features < n_samples
    S = (X * X') / N;
    [evec, eval] = eigenvalue_decomposition(S);
    p = min([length(eval), n_features, n_samples]);
    if whiten
      U = evec(:,1:p) * diag(eval(1:p).^(-0.5));
    else
      U = evec(:,1:p);
    end
  else
    S = (X' * X) / N;
    [evec, eval] = eigenvalue_decomposition(S);
    p = min([length(eval), n_features, n_samples]);
    if whiten
      aux = 1;
    else
      aux = 0.5;
    end
    U = (X * evec(:,1:p)) * diag((N * eval(1:p)).^(-aux));
  end

  % Weighting (done by Matlab, useful for AAMs)
  if wheight
    U = U * diag(eval(1:p).^(0.5));
  end

  eval = eval(1:p);

end