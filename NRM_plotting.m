function NRM_plotting(x,solution,time,plott,type)
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
%plotting_well function plots the concentration profiles for a radial flow
%of nanofluid injection
%   solution: solution data
%   time: printing time
%   plott: if plots are requested

if plott=="yes"
    figure(1)
    hold on;
    title('Nanoparticle-in-fluid concentration','Interpreter','Latex')
    xlim([min(x) max(x)]);
    if type=="linear"
        xlabel('$x_D$','Interpreter','Latex');
    elseif type=="radial"
        xlabel('$r_D$','Interpreter','Latex');
    end
    ylabel('$c_D$','Interpreter','Latex');

    figure(2)
    hold on;
    title('Nanoparticle-on-rock concentration','Interpreter','Latex')
    xlim([min(x) max(x)]);
    if type=="linear"
        xlabel('$x_D$','Interpreter','Latex');
    elseif type=="radial"
        xlabel('$r_D$','Interpreter','Latex');
    end
    ylabel('$s_D$','Interpreter','Latex');

    for i=1:length(time)
        plot_pos=find(solution.t==time(i));
        lgn(i)=string(num2str(time(i)));
        figure(1)
        plot(solution.u(:,plot_pos));

        figure(2)
        plot(solution.s(:,plot_pos));

    end
    figure(1)
    lgd=legend(lgn,'Interpreter','Latex');
    title(lgd,'$t_D$','Interpreter','Latex');
    figure(2)
    lgd=legend(lgn,'Interpreter','Latex');
    title(lgd,'$t_D$','Interpreter','Latex');
    
    if type=="linear"
        figure(3)
        plot(solution.t,solution.u(max(x),:));
        xlabel('$u_Dt_D$','Interpreter','Latex');
        ylabel('$c_D(x_D=1)$','Interpreter','Latex');
        title('Breakthrough curve concentration','Interpreter','Latex')
    end
end
end

