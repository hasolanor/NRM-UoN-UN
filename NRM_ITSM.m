%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Authors: Hillmert Solano, Nicol�s Bueno, Matteo Icardi, Juan M. Mej�a
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
%Solano, H.A., Icardi, M., Mej�a J.M.: Nanoparticle transport and retention
%in porousmedia: Darcy-scale modelling and dimensionalanalysis. Submitted
%to publication (2020).

%Zhang,  T.:  Modeling  of  Nanoparticle  Transport  in  Porous  Media.   
%PhD  Dissertation,The University of Texas at Austin (2012).
%URL http://hdl.handle.net/2152/ETD-UT-2012-08-6044

%Platte, R.B., Trefethen, L.N.: Chebfun: A New Kind of Numerical Computing.
%In: A.D.Fitt, J. Norbury, H. Ockendon, E. Wilson (eds.) Progress in 
%Industrial Mathematics atECMI 2008, Mathematics in Industry, pp. 69�87. 
%Springer, Berlin, Heidelberg (2010).DOI 10.1007/978-3-642-12110-45.  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parameter assignment for ITSM (Zhang, 2012)
% 0: Variables associated with reversible site
% 1: Variables associated with irreversible site
Da0=parameters(1);
Da1=parameters(2);
k0s=parameters(3);
k0cs=parameters(4)^(-1); % ITSM considers s_max:=1/kcs
k1cs=parameters(5)^(-1); % ITSM considers s_max:=1/kcs

%Retention function for both active sites over the rock
F0=@(c,s) (Da0./cond.v).*(c-k0s.*s-k0cs.*c.*s.*cond.c);
F1=@(c,s) (Da0./cond.v).*(c-k1cs.*c.*s.*cond.c);

%PDE-customised array
pdefun = @(t,x,s0,s1,u) [F0(u,s0); F1(u,s1);...
            -F(u,s)+(iPe(1)+iPe(2)./cond.v).*diff(u,2)-diff(u)];

%PDE-customised solution with ChebFun
[solution.t, solution.s, solution.s1, solution.u] = ...
        pde23t(pdefun, t, init.sol0, init.bc, opts);

solution.s=solution.s1+solution.s2;