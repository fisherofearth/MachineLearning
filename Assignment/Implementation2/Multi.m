function [piy] = Multi(data,label,alpha)
    num_word = 61188;
    s1 = size(label,1);
    m1 = max(label);
    py = zeros(m1, 1);
    ws = num_word;%max(data(:,2));
    ds = size(data,1);
    for i = 1 : m1
        for j = 1 : s1
            if label(j,1) == i
                py(i,1) = py(i,1)+1;
            end
        end
    end

    py = py/s1;

    piy = zeros(m1,ws);

    for n = 1 : ds
         piy(label(data(n,1),1),data(n,2)) = piy(label(data(n,1),1),data(n,2)) + data(n,3);
    end

    nump = zeros(m1,1);

    for n = 1:ds
        nump(label(data(n,1)),1) = nump(label(data(n,1)),1) + data(n,3);
    end

    for i = 1 : m1   
            piy(i,:) = (piy(i,:) + alpha)/(nump(i,1) + (alpha*ws));
    end

    piy = piy';
end


