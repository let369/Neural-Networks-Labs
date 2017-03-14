function [output] = activation_function(x)
    % Define the sigmoid function here
    for i=1:size(x)
        if x(i)>=0
            x(i) = 1;
        else
            x(i)= -1;
        end
    end
    [output] = x;
end