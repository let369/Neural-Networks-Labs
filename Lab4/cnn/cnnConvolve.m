function convolvedFeatures = cnnConvolve(filterDim, numFilters, images, W, b)
%cnnConvolve Returns the convolution of the features given by W and b with
%the given images
%
% Parameters:
%  filterDim - filter (feature) dimension
%  numFilters - number of feature maps
%  images - large images to convolve with, matrix in the form
%           images(r, c, image number)
%  W, b - W, b for features from the sparse autoencoder
%         W is of shape (filterDim,filterDim,numFilters)
%         b is of shape (numFilters,1)
%
% Returns:
%  convolvedFeatures - matrix of convolved features in the form
%                      convolvedFeatures(imageRow, imageCol, featureNum, imageNum)

numImages = size(images, 3);
imageDim = size(images, 1);
convDim = imageDim - filterDim + 1;
convolvedFeatures = zeros(convDim, convDim, numFilters, numImages);

% Instructions:
%   Convolve every filter with every image here to produce the 
%   (imageDim - filterDim + 1) x (imageDim - filterDim + 1) x numFeatures x numImages
%   matrix convolvedFeatures, such that 
%   convolvedFeatures(imageRow, imageCol, featureNum, imageNum) is the
%   value of the convolved featureNum feature for the imageNum image over
%   the region (imageRow, imageCol) to (imageRow + filterDim - 1, imageCol + filterDim - 1)
%
% Expected running times: 
%   Convolving with 100 images should take less than 30 seconds 
%   Convolving with 5000 images should take around 2 minutes
%   (So to save time when testing, you should convolve with less images, as
%   described earlier)

%%% Add code here
    for i=1:numImages
        im = images(:,:,i);
        for j=1:numFilters
            x=1;
            y=1;
%             cw = rot90(W(:,:,j));
%             cf = conv2(im,cw,'valid') + b(j);
%             convolvedFeatures(:,:,j,i) = 1./(1+exp(-cf));
            for k=1:convDim
                for l=1:convDim
                    convolvedFeatures(x,y,j,i) = 1./(1+exp(-(sum(sum(...
                        im(k:k+filterDim-1,l:l+filterDim-1).*W(:,:,j)))+...
                        b(j))));
                    if(y==convDim)
                        x=x+1;
                        y=1;
                    else
                        y = y+1;
                    end
                end
            end
        end
    end
end

