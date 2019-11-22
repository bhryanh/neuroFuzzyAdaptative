close all;
clear all;
clc;

load dinamico/ydt2;
load dinamico/ydv2;
ydt = ydt2;
ydv = ydv2;
xv = xv2;
xt = xt2;

m=2;
alfa=0.01;
n=3;
nEp=7;
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
            dedys = ys(k) - ydt(k);
            dydqj = 1;   
            for i=1:n
                dwdcij = w(j)*((xt(k,i)-c(i,j))/(s(i,j)^2));
                dwdsij = w(j)*(((xt(k,i)*c(i,j))^2)/(s(i,j)^3));
                dydpij = xt(k,i);
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

for k=1:npv
    [ysaida(k),y,w,b] = saida(xv(k,:),p,q,s,c,m,n);
end
plot(ysaida,'r');
hold on
plot(ydv)

