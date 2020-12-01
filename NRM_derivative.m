function Y=NRM_derivative(x,y)
%derivative function estimates derivative of a set of data using 
% central differences
%   x: set of x-data
%   y: set of y-data

for i=2:length(x)-1
    
    Y(i-1)=(y(i+1)-y(i-1))/(x(i+1)-x(i-1));

end

end

