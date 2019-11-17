close all;
clear all;
clc;

load ydt;
load ydv;

m=5;
alfa=0.1;
n=1;
nEp=5;
npt=length(ydt);
npv=length(ydv);

xmin = min(xt);
xmax = max(xt);
delta=(xmax-xmin)/(m-1);

for j=1:m
   for i=1:n
      c(i,j) = xmin(i) + (j-1)*delta(i);
      s(i,j) = 0.5*delta(i)*sqrt(1/(2*log(2)));
      p(i,j) = rand;
   end
   q(j) = rand;
end

for l=1:nEp
    for k=1:npt
        %calcular ys, y, w e b
        [ys(k),y,w,b] = saida(xt(k,:),p,q,s,c,m,n);
        for j=1:m
            dysdwj = (y(j) -  ys(k)) / b;
            dysdyj = w(j) / b;
            dedys = ys(k) - ydt(k,:);
            dydqj = 1;   
            for i=1:n
                dwdcij = w(j)*((xt(k,:)-c(i,j))/(s(i,j)^2));
                dwdsij = w(j)*(((xt(k,:)*c(i,j))^2)/(s(i,j)^3));
                dydpij = xt(k,:);
                dedcij = dedys*dysdwj*dwdcij;
                dedsij = dedys*dysdwj*dwdsij;
                dedpij = dedys*dysdyj*dydpij;
                dedqij = dedys*dysdyj*dydqj;
            
                c(i,j) = c(i,j) - (alfa*dedcij);
                s(i,j) = s(i,j) - (alfa*dedsij);
                p(i,j) = p(i,j) - (alfa*dedpij);
                q(j) = q(j) - (alfa*dedqij);
            end
        end
    end
end

for k=1:npt
    [ysaida(k),y,w,b] = saida(xt(k,:),p,q,s,c,m,n);
end
plot(xt,ysaida,'.');
hold on
plot(xv,ydv)
