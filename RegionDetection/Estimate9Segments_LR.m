function [ M ] = Estimate9Segments_LR( image, baseRect, PCs,weights)
% baseRect - [xmin ymin width height]

    

    bx = baseRect(1);
    by = baseRect(2);
    bw = baseRect(3);
    bh = baseRect(4);

    H = size(image,1);
    W = size(image,2);

    M = zeros(H,W); 
    
    % define the 9 rectangles
    R = [   1,          1,          bx-1,       by-1;...
            bx,         1,          bw,         by-1;...
            bx+bw,      1,          W-bx-bw+1,  by-1;...

            1,          by,         bx-1,       bh;...
            bx,         by,         bw,         bh;...
            bx+bw,      by,         W-bx-bw+1,  bh;...

            1,          by+bh,    bx-1,       H-by-bh+1;...
            bx,         by+bh,    bw,         H-by-bh+1;...
            bx+bw,      by+bh,    W-bx-bw+1,  H-by-bh+1;...
            ];


    param.imageSize = [256 256]; % it works also with non-square images
    param.orientationsPerScale = [8 8 8 8];
    param.numberBlocks = 4;
    param.fc_prefilt = 4;    
    
    for i = 1 : 9
        ROI = imcrop(image,R(i,:));
        [gist, ~] = LMgist(ROI, '', param);

%         y_hat = NeuralNetworkPredict( gist,PCs, W_ij, W_jk );
        y_hat = LogisticRegressionPredict( gist, PCs, weights );

        for x = R(i,1) : R(i,1) + R(i,3)-1
            for y = R(i,2) : R(i,2) + R(i,4)-1
                M(y, x) = y_hat;
            end
        end


    end

   

end
