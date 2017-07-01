function output= dprep(input)
% Sizes data array y so that it can be plotted in the graph dx vs dy
    len=length(input)-1;
    output=zeros(1,len);
    for i=1:len
        output(i)=(input(i)+input(i+1))/2;
    end
end

