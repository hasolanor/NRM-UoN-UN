# NRM-UoN-UN

NRM is a set of scripts to solve several problems related to nanoparticle transport-and-retention in porous media. It was developed as an outcome of the project "Development of a robust modelling and up-scaling techniques for studying nanofluids transportand retention in porous rocks for subsurface engineering applications" funded by the Royal Academy of Engineering of the United Kingdom under the Industry  Academia  Partnership  Programme  -  17/18(IAPP100080). 

Authors: Hillmert A. Solano (1), Matteo Icardi (2), Nicolás Bueno (1), Juan M. Mejía (1).

(1): Flow and Transport Dynamics in Porous Media group, Faculty of Mines, Universidad Na-cional de Colombia, Robledo Campus, 050041, Medell ́ın, Colombia.
(2): Multiscale  Modelling  and  Heterogeneous  Media  group,  School  of  Mathematical  Sciences,University of Nottingham, University Park, NG7 2RD, Nottingham, United Kingdom.

Corresponding e-mail: hasolanor@unal.edu.co

Note: To run any of the scripts, ChebFun must be downloaded. Some hints are in the site: https://www.chebfun.org/download/

## fitting_retention_parameters
This script computes a set of model parameters for which the model reachs the best agreement with experimental data. This code minimise the error between both results. As input, experimental data, experiments conditions, and model seed are requested.

## linear_problem_simulation
This script simulates a nanofluid injection under linear flow condition. As input, modelling parameters are requested.

## radial_problem_simulation
This script simulates a nanofluid injection under radial flow condition. As input, modelling parameters are requested.

# References
* Solano, H.A., Icardi, M., Mejía J.M.: Nanoparticle transport and retention in porousmedia: Darcy-scale modelling and dimensionalanalysis. Submitted to publication (2020).

* Zhang,  T.:  Modeling  of  Nanoparticle  Transport  in  Porous  Media. PhD  Dissertation,The University of Texas at Austin (2012). URL http://hdl.handle.net/2152/ETD-UT-2012-08-6044

* Platte, R.B., Trefethen, L.N.: Chebfun: A New Kind of Numerical Computing. In: A.D.Fitt, J. Norbury, H. Ockendon, E. Wilson (eds.) Progress in Industrial Mathematics atECMI 2008, Mathematics in Industry, pp. 69–87. Springer, Berlin, Heidelberg (2010).DOI 10.1007/978-3-642-12110-45.  
