epoch_n = 10;

in_fis = genfis1([xt ydt],5,'gaussmf');

out_fis = anfis([xt ydt], in_fis, epoch_n);

ysmat = evalfis(xv,out_fis);

plot(xv,ydv,xv,ysmat);

fis = genfis2(xt,ydt, 0.5);

ysmat2 = evalfis(xv,fis);

figure;

plot(xv,ydv,xv,ysmat2);