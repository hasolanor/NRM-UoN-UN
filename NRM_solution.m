function solution =NRM_solution(t,iPe,name,parameters,cond,x,init)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Authors: Hillmert Solano, Nicolás Bueno, Matteo Icardi, Juan M. Mejía
%Institutions: University of Nottingham & Universidad Nacional de Colombia
%Corresponding mail: hasolanor@unal.edu.co
%This file and the others are licensed. Check this in the license file that
%is avaliable in the repository

%DESCRIPTION
%This algorithm seeks a set of retention model parameters that allows to
%reach the minimum error between retention models and experimental data.
%PDE-based models are solved using ChebFun package.

%FUNDING
%Industry  Academia  Partnership  Programme  -  17/18(IAPP100080)
%Royal Academy of Engineering of the United Kingdom
%Project: Development of a robust modelling and up-scaling techniques for 
%studying nanofluids transportand retention in porous rocks for subsurface
%engineering applications

%REFERENCES
%Solano, H.A., Icardi, M., Mejía J.M.: Nanoparticle transport and retention
%in porousmedia: Darcy-scale modelling and dimensionalanalysis. Submitted
%to publication (2020).

%Zhang,  T.:  Modeling  of  Nanoparticle  Transport  in  Porous  Media.   
%PhD  Dissertation,The University of Texas at Austin (2012).
%URL http://hdl.handle.net/2152/ETD-UT-2012-08-6044

%Platte, R.B., Trefethen, L.N.: Chebfun: A New Kind of Numerical Computing.
%In: A.D.Fitt, J. Norbury, H. Ockendon, E. Wilson (eds.) Progress in 
%Industrial Mathematics atECMI 2008, Mathematics in Industry, pp. 69–87. 
%Springer, Berlin, Heidelberg (2010).DOI 10.1007/978-3-642-12110-45.  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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