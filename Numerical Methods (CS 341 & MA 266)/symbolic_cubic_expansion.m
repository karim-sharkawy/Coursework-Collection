function expanded_form = expand_cubic(factorized_expression)
    % Input: factorized_expression (string or symbolic expression)
    % Output: expanded_form (the expanded polynomial)

    % Check if the input is symbolic or string
    if ischar(factorized_expression) || isstring(factorized_expression)
        % Convert the input string to a symbolic expression
        factorized_expression = str2sym(factorized_expression);
    end
    
    % Expand the factorized cubic expression
    expanded_form = expand(factorized_expression);
    
    % Display the result
    disp('Expanded Polynomial:');
    disp(expanded_form);
end

factorized_expr = '(3 - x)^3';

% Call the function to expand the expression
expanded_expr = expand_cubic(factorized_expr);