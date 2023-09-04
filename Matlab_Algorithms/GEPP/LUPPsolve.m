function x = LUPPsolve(A,b)
  [L, U, P] = LUPPdec(A);
  y = Lsol(L,P*b);
  x = Usol(U,y);
endfunction

function [Lnew, U, P] = LUPPdec(A)
# Initialization
n = size(A,1);
P = eye(n,n); 
L = zeros(n,n);
# Main Process
for j=1:n-1 #stiles
  [~,pos]=max(abs(A(j:n,j))); #Pos is the position of max column element of vector A(i+1:n, i)=>truepos= pos+i
  A([j,j+pos-1],:) = A([j+pos-1,j],:) ;
  P([j,j+pos-1],:) = P([j+pos-1,j],:) ;
  L([j,j+pos-1],:) = L([j+pos-1,j],:) ;
  for i=j+1:n #grammes
      L(i,j) = A(i,j)/A(j,j) ; #pollaplasiastes
      for k=j+1:n 
          A(i,k) = A(i,k) - L(i,j)*A(j,k) ;
      endfor
  endfor
  U=triu(A);
  Lnew= eye(size(L)) + L
endfor

function y = Lsol(L,b)
    n = size(L,1);
    y=zeros(n,1);
    for i=1:n
        y(i) = b(i);
        for k=1:i-1
            y(i) = y(i) - L(i,k)*y(k);
        endfor
        y(i) = y(i)/L(i,i);
    endfor
endfunction

function x = Usol(U,y)
  n = length(y);
  x=zeros(n,1);
  for i=n:-1:1
      x(i)=y(i);
      for k=i+1:n
          x(i) = x(i) - U(i,k)*x(k);
      endfor
      x(i) = x(i)/U(i,i);
  endfor
endfunction  