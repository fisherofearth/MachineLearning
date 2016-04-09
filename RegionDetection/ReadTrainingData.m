function [ data ] = ReadTrainingData( file_path, image_kind)
%READTRAININGDATA Summary of this function goes here
%   Detailed explanation goes here


    
%     img_path_list = dir(strcat(file_path, image_kind));
%     img_num = length(img_path_list);
% %     image = zeros(40,100,img_num);
%     
%     data = [];
%     if img_num > 0
%         for j = 1:img_num 
%             image_name = img_path_list(j).name;
%             image=  im2single(imread(strcat(file_path,image_name))); 
%             [ ~, SIFTs ] = SelectBestSIFT( image, num, max);
%             if(size(SIFTs,2)>0)
%                 for n = 1 : num
%                     data = vertcat(data, SIFTs(:,n)');
%                 end
% %                 data = vertcat(data,SIFTsToSingleVector( SIFTs )');
%             end
% %             data = SIFTsToSingleVector( SIFTs )';
%         end  
%     end
%     
%     
% end

    % Parameters:
    clear param
    
    param.imageSize = [256 256]; % it works also with non-square images
    param.orientationsPerScale = [8 8 8 8];
    param.numberBlocks = 4;
    param.fc_prefilt = 4;
    
    img_path_list = dir(strcat(file_path, image_kind));
    img_num = length(img_path_list);

    data = [];
    if img_num > 0
        for j = 1:img_num 
            image_name = img_path_list(j).name;
            image= imread(strcat(file_path,image_name)); 
            
%             image = imcrop(image,[18,8,64,24]);
            
            [gist1, ~] = LMgist(image, '', param);
            data = vertcat(data, gist1);
        end  
    end
    data = double(data);
    
end

