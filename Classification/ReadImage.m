function [ image ] = ReadImage( filename )
image = [];
     fullFilename = [num2str(filename) '.png'];% get filename from the image list
     rawImage= rgb2gray(imread(fullFilename));% convert a RGB image to Gray image
     s = size(rawImage);
     image = double(reshape(rawImage,s(1) * s(2) ,1)); 
end

