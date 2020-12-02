# NRM-UoN-UN

NRM is a set of scripts to solve several problems related to nanoparticle transport-and-retention in porous media. It was developed as an outcome of the project "Development of a robust modelling and up-scaling techniques for studying nanofluids transportand retention in porous rocks for subsurface engineering applications" funded by the Royal Academy of Engineering of the United Kingdom under the Industry  Academia  Partnership  Programme  -  17/18(IAPP100080). 

Authors: Hillmert A. Solano (1), Matteo Icardi (2), Nicolás Bueno (1), Juan M. Mejía (1).

(1): Flow and Transport Dynamics in Porous Media group, Faculty of Mines, Universidad Na-cional de Colombia, Robledo Campus, 050041, Medell ́ın, Colombia.
(2): Multiscale  Modelling  and  Heterogeneous  Media  group,  School  of  Mathematical  Sciences,University of Nottingham, University Park, NG7 2RD, Nottingham, United Kingdom.

Corresponding e-mail: hasolanor@unal.edu.co

# fitting_retention_parameters
This script computes a set of model parameters for which the model reachs the best agreement with experimental data. This code minimise the error between both results. As input, experimental data, experiments conditions, and model seed are requested.

# linear_problem_simulation
This script simulates a nanofluid injection under linear flow condition. As input, modelling parameters are requested.

# radial_problem_simulation
This script simulates a nanofluid injection under radial flow condition. As input, modelling parameters are requested.
