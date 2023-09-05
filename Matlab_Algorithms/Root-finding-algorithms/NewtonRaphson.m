function [root,counter] = newton_raphson(x0,f,df,tol,Nmax)
  x_n0 = x0;
  x_n1 =  x_n0 - (f(x_n0)/df(x_n0)) ;
  counter = 1;
  while abs(x_n1-x_n0) > tol && counter < Nmax 
    x_n0 = x_n1 ;
    x_n1 =  x_n0 - (f(x_n0)/df(x_n0)) ;
    counter = counter + 1;
  endwhile
  root = x_n1;
endfunction  