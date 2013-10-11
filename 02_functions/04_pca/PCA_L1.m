function U = PCA_L1 (X, k)

    [d, n] = size(X);
    
    n = min(n, k);
    
    U = zeros(d, n);
    
    U = private_PCA_L1(X, U, 1, n);
    
end

function U = private_PCA_L1(X, U, c, n)

    if n == 0
        return;
    end
    
    [~, i] = max(sum(X.^2));
  
    
    
    w_pre = X(:,i);
    w_pre = w_pre / sqrt(w_pre' * w_pre);
    
    %plot([0, w_pre(1)], [0, w_pre(2)]);
    %hold on;
    
    running = true;
    
    while (running)
       
        %comment by thanos
        % if ((w_pre' * X) >= 0)
        %    p=1 ;
        % else
        %    p=-1;
        % end
        p = -1 + ((w_pre' * X) >= 0) * 2;
        
        w_new = X * p';
        w_new = w_new / sqrt(w_new' * w_new);
        
        if (w_pre == w_new)
            
            if sum((w_new' * X) == 0) > 0
                w_new = w_new + 0.001 * rand(d,1);
                w_new = w_new / sqrt(w_new' * w_new);
            else
                running = false;
            end
            
        end
        
        w_pre = w_new;
        %plot([0, w_pre(1)], [0, w_pre(2)]);
        
    end

    U(:,c) = w_pre;
    
    %hold off;
    %fprintf('N: %d\n', n);
    U = private_PCA_L1(X - w_pre * (w_pre' * X), U, c+1, n-1);
end