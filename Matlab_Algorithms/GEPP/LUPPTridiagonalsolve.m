function x = LUPPTridiagonalsolve(A,b)
    [L, U, P] = LUPPdecTridiagonal(A);
    y = LsolTridiagonal(L,P*b);
    x = UsolTridiagonal(U,y);
endfunction    

function [Lnew,U,P] = LUPPdecTridiagonal(A)
  # Initialization
  n = size(A,1);
  P = eye(n,n); 
  L = zeros(n,n);
  # Main Process
  for j=1:n-1 #columns
    if abs(A(j,j)) < abs(A(j+1,j)) 
      A([j,j+1],:) = A([j+1,j],:) ;
      P([j,j+1],:) = P([j+1,j],:) ;
      L([j,j+1],:) = L([j+1,j],:) ;
    endif  
      L(j+1,j) = A(j+1,j)/A(j,j) ; 
      A(j+1,j+1) = A(j+1,j+1) - L(j+1,j)*A(j,j+1) ;
    if(j != n-1) 
      A(j+1,j+2) = A(j+1,j+2) - L(j+1,j)*A(j,j+2) ;
    endif 
  end
  U=triu(A);
  Lnew= eye(size(L)) + L;
endfunction  

function y = LsolTridiagonal(L,b)
    n = size(L,1);
    y=zeros(n,1);
    y(1) = b(1)/L(1,1) ;
    y(2) = (b(2)-L(2,1)*y(1)) /L(2,2) ;
    for i=3:n
        y(i) = ( b(i) - L(i,i-2)*y(i-2)- L(i,i-1)*y(i-1) ) / L(i,i) ;
    end
endfunction

function x = UsolTridiagonal(U,y)
    n = length(y);
    x=zeros(n,1);
    x(n)=y(n)/U(n,n);
    x(n-1)=( y(n-1)-U(n-1,n)*x(n) )/U(n,n);
    for i=n-2:-1:1
        x(i) = (y(i) - U(i,i+1)*x(i+1)- U(i,i+2)*x(i+2) )/U(i,i);
    end
endfunction