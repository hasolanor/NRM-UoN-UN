function NRM_plotting_fit(solution,exp,cond)
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
%optimisation function seeks the best set of parameters matching with the
%experimental data
%   exp: experimental data (contains exp.t, exp.c, exp.C, exp.dc)
%   solution: solution data
%   model: model data (contains model.name and model.parameters)
%   cond: experimental parameters (contain cond.c and cond.v)
%   x: spatial domain (a pre-defined chebfun is expected)
%   init: initial and boundary conditions (contain init.sol0 and init.bc)

figure(1)
for i=1:length(exp)
    plot(solution.t,solution.u(max(x),:)); hold on
    plot(exp.t,exp.c,'d');
    lgn(2*i)=string(cond(i).v);
    lgn(2*i-1)=string(cond(i).v);
    xlabel('$u_Dt_D$','Interpreter','Latex');
    ylabel('$c_D(x_D=1)$','Interpreter','Latex');
    title('Breakthrough curve concentration','Interpreter','Latex')
end
lgd=legend(lgn,'Interpreter','Latex');
title(lgd,'$t_D$','Interpreter','Latex');