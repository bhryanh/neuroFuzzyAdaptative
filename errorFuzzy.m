close all;
clear all;
clc;

x=(-2:0.001:2)';

param = readfis('sugeno.fis');

yd=x.^2;

ys=evalfis(x,param);

plot(x,yd,x,ys);

erro=0;
np=length(x);

for k=1:np
   erro=erro+(ys(k)-yd(k))^2; 
end

erro=0.5+erro/np;