function [init,x]=NRM_initialisation(name,cond,radial)
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
%initialisation function initialisates the problem assigning initial and
% boundary conditions
%   name: name of the retention model
%   cond: experimental parameters (contain cond.c and cond.v)


if (radial=="yes")
    x = chebfun(@(x) x, [1 cond.rmx]);
    u0 = cond.c.*(1-tanh((x-1)*100)); %Initial condition
    s0 = u0*0; %Initial condition
    
    init.sol0=[s0, u0];
    
    init.bc.left = @(t,s,u) u-cond.c*0.5*(1-erf(1000*(t-cond.slug)));
    init.bc.right = @(t,s,u) diff(u); %Left Condition on boundary

else %Linear flow-
    
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
        init(i).bc.left = @(t,s,u) u-(cond(i).c/2)*(1-tanh((t-cond(i).slug-0.05)*1000));
        %Boundary condition for concentration at production is zeroGradient
        init(i).bc.right = @(t,s,u) diff(u);
    end

end

end

