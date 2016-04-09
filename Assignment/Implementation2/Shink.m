function [ newData ] = Shink( trainData, shinkedDictIdx)
%SHINK Summary of this function goes here
%   Detailed explanation goes here

%     data = trainData;
%     newData = [];
%     c = 1;
%     for i = 1 : size(trainData,1)
%         if (size(find(shinkedDictIdx == trainData(i,2)),1) > 0)
%             newData(c,:) = trainData(i,:);
%             c = c + 1;
%         end
%     end


    data = trainData;
    newData = [];
    c = 1;
    for i = 1 : size(trainData,1)
        if (size(find(shinkedDictIdx == trainData(i,2)),1) > 0)
            newData(c,:) = trainData(i,:);
            c = c + 1;
        end
    end
    
end

