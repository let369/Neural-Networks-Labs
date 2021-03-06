function pooledFeatures = cnnPool(poolDim, convolvedFeatures)
%cnnPool Pools the given convolved features
%
% Parameters:
%  poolDim - dimension of pooling region
%  convolvedFeatures - convolved features to pool (as given by cnnConvolve)
%                      convolvedFeatures(imageRow, imageCol, featureNum, imageNum)
%
% Returns:
%  pooledFeatures - matrix of pooled features in the form
%                   pooledFeatures(poolRow, poolCol, featureNum, imageNum)
%     

numImages = size(convolvedFeatures, 4);
numFilters = size(convolvedFeatures, 3);
convolvedDim = size(convolvedFeatures, 1);
pooledFeatures = zeros(convolvedDim / poolDim, ...
        convolvedDim / poolDim, numFilters, numImages);
% Instructions:
%   Now pool the convolved features in regions of poolDim x poolDim,
%   to obtain the 
%   (convolvedDim/poolDim) x (convolvedDim/poolDim) x numFeatures x numImages 
%   matrix pooledFeatures, such that
%   pooledFeatures(poolRow, poolCol, featureNum, imageNum) is the 
%   value of the featureNum feature for the imageNum image pooled over the
%   corresponding (poolRow, poolCol) pooling region. 
%   
%   Use mean pooling here.


for i = 1:numImages
    for j = 1:numFilters
        for z = 1:(convolvedDim/poolDim)
            for y = 1:(convolvedDim/poolDim)
                %Keeping the step 1 but configuring the range like current
                %place in the map multiplied by poolDim. We substract the
                %poolDim from the starting position but not from the ending
                %position so we are configuring the range like this. Also
                %in the starting position we are adding 1 since in matlab
                %the counting starts from 1. We use the same formula in
                %both dimensions.
            	temp_matrix = convolvedFeatures((z*poolDim)-poolDim+1:z*poolDim, ...
                    (y*poolDim)-poolDim+1:y*poolDim,j,i);
                pooledFeatures(z,y,j,i) = mean2(temp_matrix);
            end
        end                
    end
end

%alternative way
%%% Add code here
%     for i=1:numImages
%         for j=1:numFilters
%             x=1;
%             y=1;
%             for k=1:poolDim:convolvedDim
%                 for l=1:poolDim:convolvedDim
%                     pooledFeatures(x,y,j,i) = mean2(convolvedFeatures...
%                         (k:k+poolDim-1,l:l+poolDim-1,j,i));
%                     if(y==(convolvedDim / poolDim))
%                         x=x+1;
%                         y=1;
%                     else
%                         y = y+1;
%                     end
%                 end
%             end
%         end
%     end
end

