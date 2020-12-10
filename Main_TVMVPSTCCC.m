%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  PBAS source codes for the TV-MVPSTC-CC problem (version 1.0 )    %
%                                                                   %
%  Developed in MATLAB R2018b                                       %
%                                                                   %
%  Author and programmer: V.N.Katsikis, S.D.Mourtas,                %
%                         P.S.Stanimirovic, S.Li, X.Cao             %
%                                                                   %
%         e-Mail: vaskatsikis@econ.uoa.gr                           %
%                 spirosmourtas@gmail.com                           %
%                 pecko@pmf.ni.ac.rs                                %
%                 shuaili@ieee.org                                  %
%                 xinweicao@shu.edu.cn                              %
%                                                                   %
%   Main paper: V.N.Katsikis, S.D.Mourtas, P.S.Stanimirovic, S.Li,  %
%               X.Cao, "Time-Varying Mean-Variance Portfolio        %
%               Selection under Transaction Costs and Cardinality   %
%               Constraint Problem," SN Oper. Res. Forum (submitted)%
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

X = xlsread('\data'); % stocks close prices

% TV-MVPSTC-CC problem parameters
n=15; % portfolio size
X=X(:,1:n); % marketed space
noep = [22; 20; 23; 20; 21; 22]; % number of observations in each month
K = 7; % cardinality number
xp = ones(n,1)/4; % initial portfolio
tspan = [0 6];
div = 10; % tspan divisions
s = 30; % number of delays
mavgt='exponential'; % moving average type: 'simple', 'linear', 'exponential'
inter='linear'; % data interpolation: 'linear', 'pchip', 'spline'

[t,xbas,xfa,xde] = TVMVPSTCCC(X,tspan,div,mavgt,inter,s,K,xp,noep);