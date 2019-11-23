
function [ys,y,w,b] = saida(x,p,q,s,c,m,n) 
     a = 0;
     b = 0;
     y = zeros(m,1);
     w = ones(m,1);
    for j=1:m
       for i=1:n
          y(j) = (p(i,j)*x(i)) + q(j) + y(j);
          u(i,j) = exp(-0.5*(((x(i)-c(i,j))/s(i,j))^2));
          w(j) = w(j) * u(i,j);  
       end
       a = a + w(j)*y(j);
       b = b + w(j);
    end
    ys = a/b;
end

