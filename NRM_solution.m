function solution =NRM_solution(t,iPe,name,parameters,cond,x,init)
%solution function solve numerically the mathematical model based on 
% a PDE-customised problem
%   exp: experimental data (contains exp.t, exp.c, exp.C, exp.dc)
%   iPe: dimensionless hydrodynamic variables (Péclet and dispersivity)
%   model: model data (contains model.name and model.parameters)
%   cond: experimental parameters (contain cond.c and cond.v)
%   x: spatial domain (a pre-defined chebfun is expected)
%   init: initial and boundary conditions (contain init.sol0 and init.bc)
    
opts = pdeset('Eps', 1e-6);
fprintf("Solving with %s \n", name);
disp(parameters);

%PDE-customised solution based on the model
if (name=="SBIM")
    %SBIM model
    NRM_SBIM;
elseif (name=="langmuir")
    %Langmuir model
    NRM_langmuir;
elseif (name=="ITSM")
    %ITSM: from the PhD Dissertation of Tiantian Zhang (U. Texas at Austin)
    NRM_ITSM;
else
    %Retention is neglected: Tracer case
    pdefun = @(t,x,u) (iPe(1)+iPe(2)/v).*diff(u,2)-diff(u);
    [solution.t, solution.u] = ...
        pde23t(pdefun, t, init.sol0, init.bc, opts);
end

%Assignment of the breakthough data
solution.c=solution.u(1,:);
solution.C=NRM_cumfunction(solution.t,solution.c);
solution.dc=NRM_derivative(solution.t,solution.c);

end