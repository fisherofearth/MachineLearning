function [outputLable maxValue accuracy runtime ] = TestMultinomial( testData, testLabel, P_wy, P_y )
%TESTMULTINOMIAL Summary of this function goes here
%   Detailed explanation goes here
    
    num_word = 61188;
    num_label = 20;
    num_doc = size(testLabel,1);

    tic
    result_dy = zeros(num_doc,num_label);
    for d = 1 : num_doc 
        doc =testData(find(testData(:,1) == d),2:3);
        for y = 1 : num_label
            P_tmp = 0;
            for w = 1:size(doc,1)
                P_tmp = P_tmp + doc(w,2)* (log(P_wy(doc(w,1),y)));
            end
            result_dy(d,y) = P_tmp + log(P_y(y,1));
        end
    end
    runtime = toc;

    [maxValue outputLable]  = max(result_dy,[],2); 
    accuracy = size(find((testLabel - outputLable) == 0),1) / num_doc;

end

