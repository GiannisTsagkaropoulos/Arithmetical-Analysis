function spline_y = NaturalCubicSpline(x, y, spline_x)
    % Initialization
    % The function takes as inputs:
    % - The x and y data used to plot our function f
    % - A vector spline_x with all the x-coordinates of the points that will be used to graph the cubic spline
    % and solves the system described below for z and then returns the y-coordinates
    % of the cubic spline for all the x-coordinates of the input, computed using the formula derived below.

    h = x(2:end) - x(1:end-1);
    f_diff = (y(2:end) - y(1:end-1)) ./ h;
    H = diag(2 * (h(1:end-1) + h(2:end))) + diag(h(2:end-1), 1) + diag(h(2:end-1), -1);
    v = 6 * (f_diff(2:end) - f_diff(1:end-1));
    
    % Solve for second derivatives of cubic polynomial, z
    z = H \ v;
    z = [0; z; 0]; % natural conditions of natural cubic spline
    b = f_diff - (z(2:end) - z(1:end-1)) .* h / 6;
    
    % Define polynomials
    spline_y = zeros(size(spline_x));
    for i = 1:length(spline_x)
        for k = 1:length(x) - 1
            if spline_x(i) <= x(k + 1)
                spline_y(i) = y(k) - z(k) * h(k)^2 / 6 + b(k) * (spline_x(i) - x(k)) + ...
                    z(k) * (x(k + 1) - spline_x(i))^3 / (6 * h(k)) + ...
                    z(k + 1) * (spline_x(i) - x(k))^3 / (6 * h(k));
                break;
            endif
        endfor
    endfor
endfunction
