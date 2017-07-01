function index = Nearest(int, array)
%   Finds nearest int in an array
    diff = abs(array-int);
    M=min(diff);
    index=find(diff==M,1);

end

