% HW2: Q9
function theta = bisection(v0, D, H, g, tol) % tol is tolerance

    v0 = 27;, D = 60;, H = 10;, g = 9.81;, tol = 1e-5;
    
    theta_min = 0;, theta_max = pi/2;
    
    while (theta_max - theta_min) > tol
        theta_mid = (theta_min + theta_max) / 2;
        
        f_mid = height_difference(v0, D, H, g, theta_mid);
        
        if f_mid > 0
            theta_max = theta_mid;
        else
            theta_min = theta_mid;
        end
    end
    
    theta = (theta_min + theta_max) / 2;
    theta_deg = rad2deg(theta);
    
    fprintf('The true theta using bijection is: %.5f radians (%.5f degrees)\n', theta, theta_deg)
end

function diff = height_difference(v0, D, H, g, theta) %finding r_i
    t = D / (v0 * cos(theta));
    y = v0 * sin(theta) * t - 0.5 * g * t^2;
    diff = y - H;
end
