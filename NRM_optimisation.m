function [optimisation]=NRM_optimisation(exp,iPe,model,cond,x,init)
%optimisation function seeks the best set of parameters matching with the
%experimental data
%   exp: experimental data (contains exp.t, exp.c, exp.C, exp.dc)
%   iPe: dimensionless hydrodynamic variables (Péclet and dispersivity)
%   model: model data (contains model.name and model.parameters)
%   cond: experimental parameters (contain cond.c and cond.v)
%   x: spatial domain (a pre-defined chebfun is expected)
%   init: initial and boundary conditions (contain init.sol0 and init.bc)
    

%Minimisation of an error function
[xopt]=fminsearch(@(par) NRM_error(exp,iPe,model.name,...
    par,cond,x,init), model.parameters);

%Assignment of best-matching parameters 
optimisation.parameters = xopt;



end

