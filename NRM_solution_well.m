function [solution] = NRM_solution_well(solution,iPe,model,x,cond,init)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Authors: Hillmert Solano, Matteo Icardi, Juan M. Mejía
%Institutions: University of Nottingham & Universidad Nacional de Colombia
%Corresponding mail: hasolanor@unal.edu.co
%This file and the orhers are licensed. Check this in the license file that
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
%solution_well function solve numerically the mathematical model based on 
% a PDE-customised problem for radial flow
%   solution: solution data (contains solution.t, solution.c)
%   iPe: dimensionless hydrodynamic variables (inv. Péclet and dispersivity)
%   model: model data (contains model.name and model.parameters)
%   cond: experimental parameters (contain cond.c and cond.v)
%   x: spatial domain (a pre-defined chebfun is expected)
%   init: initial and boundary conditions (contain init.sol0 and init.bc)

%Numerical Control
opts = pdeset('Eps', 1e-6);

if model.name=="SBIM"
    Da0=model.parameters(1);
    Da1=model.parameters(2);
    ks0=model.parameters(3);
    kcs0=model.parameters(4);
    ks1=model.parameters(5);
    kcs1=model.parameters(6);

    %Retention Function for SBIM
    F=@(c,s,x) Da0.*(c-ks0.*s-kcs0.*c.*s.*cond.c)+...
        Da1.*(c-ks1.*s-kcs1.*c.*s.*cond.c)*cond.v./x; 
    
elseif model.name=="langmuir"
    Da0=model.parameters(1);
    ks0=model.parameters(2);
    kcs0=model.parameters(3)^(-1);

    %Retention Function for Langmuir
    F=@(c,s,x) Da0.*(c-ks0.*s-kcs0.*c.*s.*cond.c);
end

pdefun = @(t,x,s,u) [F(u,s,x);...
    -F(u,s,x)-(cond.v-2.*iPe(1)-iPe(2).*cond.v./x).*(1./x).*diff(u,1)+...
    (iPe(1)+iPe(2).*cond.v./x).*diff(u,2)-(iPe(2).*cond.v.*(u./x.^2))];

t=solution.t;
[solution.t, solution.s, solution.u] = ...
    pde23t(pdefun, t, init.sol0, init.bc, opts);

end