%% Fitting Retention Parameters 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Authors: Hillmert Solano, Matteo Icardi, Juan M. Mej�a
%Institutions: University of Nottingham & Universidad Nacional de Colombia
%Corresponding mail: hasolanor@unal.edu.co

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

close all
clear all
clc

%Dimensionless conditions for both experiments.
%cond.c: Dimensionless concentration at injection
%cond.v: Dimensionless velocity at injection
%cond.slug: Pore Nanofluid-volume Injected into the sample
cond(1).c=1; cond(2).c=1; cond(1).slug=[2.9];
cond(1).v=1; cond(2).v=8.15; cond(2).slug=[3.1];

%Name of the files. It must be in agreement with the size of the cond array
files = ["exp91.txt", "exp92.txt"];

%ReadFiles. NRM_readfiles returns the experimental data
%exp.t: Dimensionless advection-time
%exp.c: Dimensionless fluid concentration at outlet
%exp.C: Dimensionless cumulative fluid concentration at outlet
%exp.dc: Dimensionless derivative fluid concentration at outlet
[exp] = NRM_readfiles(files,"yes");

%model.name: two-sites (Zhang,2012); SBIM (Solano et. al, 2020), Langmuir
model.name="SBIM";
%model.parameters: optimisation seed. For SBIM, 6 parameters are expected
%(1): N_Da(0), (2): N_Da(1), (3): ks(0), (4): kcs(0), (5): ks(1), (6): kcs(1)
model.parameters= [4, 0.5, 1.5 1 0 0];

%Initialisation algorithm. Return the initial and the boundary condition
%functions.
[init,x]=NRM_initialisation(model.name,cond);

%iPe: Contains hydrodynamic parameters
% in order (1): P�clet Number, (2): dimensionless dispersivity
iPe=[0.0133,0.1356];

%Optimisation algorithm. Return the best array of model parameters matching
%with the experimental data, according to the seed 
[optimisation]=NRM_optimisation(exp(1),iPe,model,cond(1),x,init(1));