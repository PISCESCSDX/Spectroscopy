function fileNum = fileNumber(i)
% This function is often used in loops in order to index throught files
    if i < 10
        fileNum = ['0000' num2str(i)];
    elseif (i >= 10 && i <100)
        fileNum = ['000' num2str(i)];
    elseif (i >= 100 && i <1000)
        fileNum = ['00' num2str(i)];
    elseif (i >= 1000 && i <10000)
        fileNum = ['0' num2str(i)];
    else
        fileNum = num2str(i);
    end 
end

