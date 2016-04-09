function [ rec_SSE, rec_gradient, ww , learningTime] = BatchGradient( data, ww0, learningRates, lambda, limit, T_converge )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Normalization
rec_SSE = zeros(limit,1) * nan;
rec_gradient = zeros(limit,1);


xx = data(:,1:45);
yy = data(:,46);

ww = ww0;   % weight vector
for time = 1 : limit
    gradientE = ((xx') * ((xx * ww) - yy)) * (1/size(data,1));
    gradientE = gradientE + (2 * lambda * ww); % add L2 term
    
    % update
    ww = ww - learningRates * gradientE;
    
    rec_SSE(time,1) = (yy - (xx * ww))' * (yy - (xx * ww)) * 0.5;
    rec_gradient(time,1) = sum(abs(gradientE));
%     
    if size( find( abs(gradientE) < T_converge),1) >= size(gradientE,1)
        break;
    end
end

learningTime = time;

end