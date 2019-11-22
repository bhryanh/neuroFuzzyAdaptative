close all;
clear all;
clc;

load dinamico/ydt2;
load dinamico/ydv2;
ydt = ydt2';
ydv = ydv2';
xv = xv2;
xt = xt2;

epoch_n = 10;

in_fis = genfis1([xt ydt]);

out_fis = anfis([xt ydt], in_fis, epoch_n);

ysmat = evalfis(xv,out_fis);

plot(ysmat);
hold on
plot(ydv);

fis = genfis2(xt,ydt, 0.5);

ysmat2 = evalfis(xv,fis);

figure;

plot(ysmat2);
hold on
plot(ydv)