function [exp] = NRM_readfiles(files,plotting)
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
%readfiles function reads the experimental data from txt files
%   files: string array with files name. One file corresponds one
%   experiment.
%   plotting: boleaan variable indicating if plotting

for i=1:length(files)
    fileID=fopen(files(i),'r');
    [A, count] = fscanf(fileID,'%f %f');
    fclose(fileID);
    A = reshape(A,2,0.5*count)';    
    exp(i).t=A(:,1)'; exp(i).c=A(:,2)';
    
    %Computing cumulative and derivative
    exp(i).C=NRM_cumfunction(exp(i).t,exp(i).c); %Same size of exp.t
    exp(i).dc=NRM_derivative(exp(i).t,exp(i).c); %Size: size of exp.t-2
    
    %Plotting option
    if (plotting=="true")
        figure(1)
        plot(exp(i).t, exp(i).c,'*'); hold on;
        
        figure(2)
        plot(exp(i).t, exp(i).C,'*'); hold on;
    end
    clear A
 end
end
