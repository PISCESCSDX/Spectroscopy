function [area] = trapArea(f,lower,upper,dX)
%Finds the area under a curve using the trapezoidal method through recursion
% "lower" and "upper" are indicies, not values
% dX is a value
if (lower < upper)
   area = ((f(lower)+f(lower+1))*(dX/2) + trapArea(f,lower+1,upper,dX));
else
    area = 0;
end

end

