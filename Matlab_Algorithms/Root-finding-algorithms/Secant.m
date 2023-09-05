function [root,counter] = secant(x0,x1,f,tol,Nmax)
  x2 = x1 - ( f(x1)*(x1-x0)/ (f(x1)-f(x0)) ) ;
  counter = 1;
  while abs(x2-x1)>tol && counter <= Nmax
    x0 = x1 ;
    x1 = x2 ;
    x2 = x1 - ( f(x1)*(x1-x0)/ (f(x1)-f(x0)) ) ;
    counter = counter + 1;
  endwhile
  root = x1;
endfunction  
 