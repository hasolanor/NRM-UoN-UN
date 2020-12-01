function [error] = NRM_error(exp,iPe,name,parameters,cond,x,init)
%error function computes the error between experimental and modelling data
%   exp: experimental data (contains exp.t, exp.c, exp.C, exp.dc)
%   iPe: dimensionless hydrodynamic variables (Péclet and dispersivity)
%   name: name of the retention model
%   parameters: model parameters to estimate the breakthrough
%   cond: experimental parameters (contain cond.c and cond.v)
%   x: spatial domain (a pre-defined chebfun is expected)
%   init: initial and boundary conditions (contain init.sol0 and init.bc)
    
%Error Initialisation
error=0;
for i=1:length(exp)
    % Solve the ADR-customised equation based on the model parameters
    solution(i)=NRM_solution(exp(i).t,iPe,name,parameters,cond(i),x,init(i));
    %IMMSE computing between model and experimental data
    error = error + immse(exp(i).c,solution(i).c);
end
fprintf('Error %4.2e \n',error)
end

