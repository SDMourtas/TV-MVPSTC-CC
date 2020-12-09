# TV-MVPSTC-CC
The Markowitz mean-variance portfolio selection is widely acclaimed as a very important investment strategy. The Time-Varying Mean-Variance Portfolio Selection under Transaction Costs and Cardinality Constraint (TV-MVPSTC-CC) problem is a time-varying nonlinear programming problem and comprises the properties of a moving average. Because of this, TV-MVPSTC-CC is more realistic and an even greater analysis tool suitable to evaluate investments and identify trading opportunities across a continuous-time period than the original mean-variance portfolio selection problem.\
The purpose of this package is to solve online the continuous TV-MVPSTC-CC problem in discrete time by using a penalty-based Beetle Antennae Search (BAS) algorithm. Several algorithms from the literature are currently implemented, based on the available literature and our understanding. More precisely, the main articles used are the followings:
* V.N.Katsikis, S.D.Mourtas, P.S.Stanimirovic, S.Li, X.Cao, "Time-Varying Mean-Variance Portfolio Selection under Transaction Costs and Cardinality Constraint Problem," SN Oper. Res. Forum (submitted)
* X.-S. Yang, Nature-inspired optimization algorithms. Elsevier, 2014.
* K. Deb, Optimization for Engineering Design: Algorithms and Examples. PHI, second ed., July 2013.
* X. Jiang and S. Li, \BAS: Beetle Antennae Search Algorithm for Optimization Problems," arXiv preprint, vol. abs/1710.10724, 2017.

Also, the package includes the following two Matlab functions for comparison purposes:
* Yarpiz (2020). Differential Evolution (DE) (https://www.mathworks.com/matlabcentral/fileexchange/52897-differential-evolution-de), MATLAB Central File Exchange. Retrieved December 8, 2020.
* Yarpiz (2020). Firefly Algorithm (FA) (https://www.mathworks.com/matlabcentral/fileexchange/52900-firefly-algorithm-fa), MATLAB Central File Exchange. Retrieved December 8, 2020.

These two Matlab functions can also be found in https://yarpiz.com/. Note that these functions have been appropriately modified for the TV-MVPSTC-CC problem.
# M-files Description
* Main_TVMVPSTCCC.m: the main function and parameters declaration
* TVMVPSTCCC.m: problem setup and main procedure
* problem.m: complementary function for the problem setup
* linots.m: time-series linear interpolation of vectors-matrices
* linotss.m: time-series linear interpolation of structures
* pchinots.m: time-series piecewise cubic Hermite interpolation of vectors-matrices
* pchinotss.m: time-series piecewise cubic Hermite interpolation of structures
* sp.m: the piecewise polynomial of the cubic spline interpolant of vectors-matrices
* splinots.m: time-series cubic spline interpolation of vectors-matrices
* sps.m: the piecewise polynomial of the cubic spline interpolant of structures
* splinotss.m: time-series cubic spline interpolation of structures
* omega.m: parameter for spliting the observations to the time periods
* objfun.m: objective function of the problem
* Sphere.m: objective function of the problem used by DE algorithm
* penfun.m: objective function of the problem plus the penalty value
* BAS.m: appropriately modified BAS algorithm
* PBAS.m: penalty-based BAS
* DE.m: appropriately modified DE algorithm
* FA.m: appropriately modified FA algorithm
# Installation
* Unzip the file you just downloaded and copy the TVMVPSTCCC directory to a location,e.g.,/my-directory/
* Run Matlab/ Octave, Go to /my-directory/ TVMVPSTCCC / at the command prompt
* run 'Main_TVMVPSTCCC' (Matlab/Octave)
# Results
After running the Main_TVMVPSTCCC.m file, the package outputs are the following:
* The optimal portfolio of TV-MVPSTC-CC problem created by BAS, DE and FA.
* The time consumptions of BAS, DE and FA.
* The graphic illustration of the optimal portfolios along with their expected return, variance and transaction cost.
# Environment
The TVMVPSTCCC package has been tested in Matlab 2018b on OS: Windows 10 64-bit.
