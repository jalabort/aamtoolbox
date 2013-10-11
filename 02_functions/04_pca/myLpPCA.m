function [U, eval] = myLpPCA(X, Lp, from_pca, whiten, bias, wheight)

  eps = 10^-1;
  Lp = Lp/2;

  n_features = size(X, 1);
  n_samples = size(X, 2);
  
  if bias
    N = n_samples;
  else
    N = n_samples - 1;
  end

  aux = 511;
  
  if n_features < n_samples
    
    if from_pca
      S = (X * X') / N;
      [evec, eval] = eigenvalue_decomposition(S);
      p = min([length(eval), n_features]);
    else
      evec = eye(n_features);
      p = n_features;
    end
    
    p = p - aux;
    U = evec(:, 1:p);
    ct = sum(sum((X - U*U'*X).^2, 1).^(Lp));
    c = 0;
    
    while norm(c-ct) > eps
      ct = c;
      %Dt = diag(Lp ./ sum((X - U*U'*X).^2, 1).^(1-Lp));
      %Bt = X * Dt * X';
      dt = Lp ./ sum((X - U*U'*X).^2, 1).^(1-Lp);
      Bt = (X .* repmat(dt, n_features, 1)) * X';
      St = Bt / N;   
      [evec, eval] = eigenvalue_decomposition(St);  
      p = min([p, length(eval), n_features]);
      
      U = evec(:, 1:p);
      
      c = sum(sum((X - U*U'*X).^2, 1).^(Lp));
      norm(c-ct)
    end
    
    if whiten
      U = U * diag(eval(1:p).^(-0.5));
    end
    
  else
    
    if from_pca
      S = (X' * X) / N;
      [evec, eval] = eigenvalue_decomposition(S);
      p = min([length(eval), n_samples]);
    else
      evec = eye(n_samples);
      p = n_samples;
    end
    
    p = p - aux;
    U = evec(:, 1:p);
    ct = sum(sum((X' - U*U'*X').^2, 1).^(Lp));
    c = 0;
    
    while norm(c-ct) > eps
      ct = c;
      %Dt = diag(Lp ./ sum((X' - U*U'*X').^2, 1).^(1-Lp));
      %Bt = X' * Dt * X;
      dt = Lp ./ sum((X' - U*U'*X').^2, 1).^(1-Lp);
      Bt = (X' .* repmat(dt, n_samples, 1)) * X;
      St = Bt / N;   
      [evec, eval] = eigenvalue_decomposition(St);
      p = min([p, length(eval), n_features]);
      U = evec(:, 1:p);
      
      c = sum(sum((X' - U*U'*X').^2, 1).^(Lp));
      norm(c-ct)
    end
    
    if whiten
      aux = 1;
    else
      aux = 0.5;
    end 
    U = (X .* repmat(dt'.^0.5, 1, n_samples)) * U * diag((N * eval(1:p)).^(-aux));
    
  end

  % Weighting (done by Matlab, useful for AAMs)
  if wheight
    U = U * diag(eval(1:p).^(0.5));
  end

  eval = eval(1:p);

end