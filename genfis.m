close all;
clear all;
clc;

load serie_temporal/ydt4;
load serie_temporal/ydv4;
ydt = ydt4;
ydv = ydv4;
xv = xv4;
xt = xt4;

epoch_n = 10;

in_fis = genfis1([xt ydt]);

out_fis = anfis([xt ydt], in_fis, epoch_n);

ysmat = evalfis(xv,out_fis);

plot(ysmat);
hold on
plot(ydv);

fis = genfis2(xt,ydt, 0.38);

ysmat2 = evalfis(xv,fis);

figure;

plot(ysmat2);
hold on
plot(ydv)