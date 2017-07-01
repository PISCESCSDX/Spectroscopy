function yy = Smoothself( y )
%   smooth function
    y1=y;
    sizem=length(y1);
    yy1=zeros(1,sizem);
    for i=1:sizem
        if(i==1 || i==sizem)
            yy1(i)=y1(i);
        elseif(i==2||i==sizem-1)
                yy1(i)=(y1(i-1)+y1(i)+y1(i+1))/3;
        else
            hold=0;
            for j=(i-2):(i+2)
                    hold=hold+y1(j);
            end
                yy1(i)=hold/5;
        end     
    end

yy=yy1;
end

