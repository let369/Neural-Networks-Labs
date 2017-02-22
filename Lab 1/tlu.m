% TLU implementation
% Tzafos Panagiotis
% Karamoulas Eleftherios

% Parameters
learn_rate = 0.1;    % the learning rate
n_epochs = 100;      % the number of epochs we want to train

% Define the inputs
examples = [0,0;0,1;1,0;1,1];

% Define the corresponding target outputs
goal = [0;1;1;0];

% Initialize the weights and the threshold
weights = rand(1,2);
threshold = rand(); 

% Preallocate vectors for efficiency. They are used to log your data 
% The 'h' is for history
h_error = zeros(n_epochs,1);
h_weights = zeros(n_epochs,2);
h_threshold = zeros(n_epochs,1);

% Store number of examples and number of inputs per example
n_examples = size(examples,1);     % The number of input patterns
n_inputs = size(examples,2);       % The number of inputs

for epoch = 1:n_epochs
    epoch_error = zeros(n_examples,1);
    
    h_weights(epoch,:) = weights;
    h_threshold(epoch) = threshold;
    
    for pattern = 1:n_examples
        
        % Initialize weighted sum of inputs
        summed_input = weights([1],[1]) * examples([pattern],[1])+weights([1],[2]) * examples([pattern],[2]);
        % Subtract threshold from weighted sum
        a = summed_input - threshold;
        % Compute output
        if(a>=0)%if the value of a is possitive or equal to zero then we have output=1
            output = 1;
        else%otherwise output is zero
            output = 0;
        end
        
        if(output~=goal([pattern]))%if the output isnt the same with our goal we have to compute new weights threshold and error.
            new_weights = weights + learn_rate*(goal([pattern])-output).*examples(pattern,:);
            new_threshold = threshold + learn_rate*(goal([pattern])-output)*(-1);
            
        else %otherwise we keep the old values and error is zero
            new_weights = weights;
            new_threshold = threshold;

        end
        % Compute error
        error = (goal([pattern])-summed_input)^2;
        % Compute delta rule
        delta_weights = weights + learn_rate*(goal([pattern])-summed_input).*examples(pattern,:);
        delta_threshold = threshold + learn_rate*(goal([pattern])-summed_input)*(-1);
        
        % Update weights and threshold
        weights = new_weights;
        threshold = new_threshold;        
    
        % Store squared error
        epoch_error(pattern) = error;%.^2 we have already computed the squared error.
    end
    
    h_error(epoch) = sum(epoch_error)/4;%computation of the mean from the error paterns
end

% Plot functions
% figure(1);
% plot(log_error)
% title('\textbf{TLU-error over epochs}', 'interpreter', 'latex', 'fontsize', 12);
% xlabel('\# of epochs', 'interpreter', 'latex', 'fontsize', 12)
% ylabel('Summed Squared Error', 'interpreter', 'latex', 'fontsize', 12)
% 
% figure(2);
% plot(1:n_epochs,h_weights(:,1),'r-','DisplayName','weight 1')
% hold on
% plot(1:n_epochs,h_weights(:,2),'b-','DisplayName','weight 2')
% plot(1:n_epochs,h_threshold,'k-','DisplayName','threshold')
% xlabel('\# of epochs', 'interpreter', 'latex', 'fontsize', 12)
% title('\textbf{Weight vector and threshold vs epochs}', 'interpreter', 'latex', 'fontsize', 12);
% h = legend('location','NorthEast');
% set(h, 'interpreter', 'latex', 'fontsize', 12);
% hold off
