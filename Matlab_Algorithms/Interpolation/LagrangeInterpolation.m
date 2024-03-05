function p_value = LagrangeInterpolation(IntP,x)
  # Initialization
  # Suppose that IntP (the matrix that holds the interpolation points) has a 2 x n dimension.
  X = IntP(1,:) ; 
  Y = IntP(2,:) ; 
  n = size(IntP,2) ;
  p_value = 0 ;
  ##
  for i=1:n 
  # Initialization     
    numerator = 1 ; 
    denominator = 1 ; 
  # Main process  
    for j=1:n
      if j!=i
        numerator = numerator * (x-X(j)) ; 
        denominator = denominator * (X(i)-X(j)) ;
      endif
    endfor
    lagrange = numerator / denominator ;
    p_value = p_value + Y(i) * lagrange;
  endfor
endfunction