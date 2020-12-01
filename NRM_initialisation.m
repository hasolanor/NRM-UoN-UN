function [init,x]=NRM_initialisation(name,cond)
%initialisation function initialisates the problem assigning initial and
% boundary conditions
%   name: name of the retention model
%   cond: experimental parameters (contain cond.c and cond.v)

%Spatial domain using chebfun
x = chebfun(@(x) x, [0 1]);
%Retained concentration at starting is zero.
s0 = x.*0; %Initial condition for retention
s1 = x.*0; %Initial condition for retention in the irreversible site -ITSM

%Array-assignment.
for i=1:length(cond) 
    %Initial condition: Injection concentration at injection corresponds
    %to boundary condition. The others are zero.
    u0 = cond(i).c.*(1-tanh((x-0.05)*100))/2; %Initial condition f
    if name=="ITSM"
        % Two active sites
        init(i).sol0=[s0,s1,u0];
    elseif (name=="SBIM"|name=="langmuir")
        % One active sites
        init(i).sol0=[s0,u0];
    else
        % No retention case
        init(i).sol0=[u0];
    end
    %Boundary condition for concentration at injection changes when nano-
    %fluid slug ends. It is a fixed-value condition
    init(i).bc.left = @(t,s,u) u-(1-tanh((t-cond(i).slug-0.05)*1000))/2;
    %Boundary condition for concentration at production is zeroGradient
    init(i).bc.right = @(t,s,u) diff(u);
end

end

