function Y=NRM_cumfunction(x,y)
%cumfunction function estimates cumulative of a set of data using 
% trapezoid rule
%   x: set of x-data
%   y: set of y-data
Y(1)=y(1);
for i=1:length(x)-1
    Y(i+1)=Y(i)+(y(i+1)+y(i))*(x(i+1)-x(i))/2;
end

end

