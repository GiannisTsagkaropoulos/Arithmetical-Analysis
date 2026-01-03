function [root, counter] = bisection(xL,xR,tol,f,N) 
  xM = (xR+xL)/2;
  counter = 0;
  while (abs(xL-xR)>tol) && (f(xM)~=0) && counter < N
    if sign(f(xL))==sign(f(xM))
      xL = xM;
    else
      xR = xM;
    end
    if sign(xL)==sign(xM)
      xM = (xR + xL)/2;
    else
       xM = xL + (xR - xL)/2;
    endif   
    counter = counter + 1;
  end 
  root=xM
  counter
endfunction