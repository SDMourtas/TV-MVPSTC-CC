% =========================================================% 
% BAS by X. Jiang and S. Li, \BAS: Beetle Antennae Search 
%
% Algorithm for Optimization Problems," arXiv preprint, 
%
% vol. abs/1710.10724, 2017.
%
% appropriately modified for the TV-MVPSTC-CC problem.
% ======================================================== %
function [xbest,fbest] = BAS(x0,xi_minus,xi_plus,A,bb,pr,w,K,R,d,delta,tmax,tol)
% bas:beetle antenna searching for global minimum 

% parameter setup
x1=x0;
eta_delta=0.991;
eta_d=0.991;
k=length(x0);
%x11=nan*ones(size(x0));
t=0;

% iteration
while t<tmax %&& norm(penfun(x11,xi_minus,xi_plus,A,bb,pr,w,K,R,x1)-penfun(x0,xi_minus,xi_plus,A,bb,pr,w,K,R,x1),2)>tol
    b=rands(k,1);
    b=b/(eps+norm(b));
    xr=x0-d*b;
    xl=x0+d*b;
    x=abs(x0+delta*b*sign(penfun(xr,xi_minus,xi_plus,A,bb,pr,w,K,R,x1)-penfun(xl,xi_minus,xi_plus,A,bb,pr,w,K,R,x1)));
    if penfun(x,xi_minus,xi_plus,A,bb,pr,w,K,R,x1)<penfun(x0,xi_minus,xi_plus,A,bb,pr,w,K,R,x1)
        %x11=x0;
        x0=x; 
    end
    delta=eta_delta*delta;
    d=eta_d*d+0.001;
    t=t+1;
end
xbest=x0;
fbest=objfun(pr,w,xbest,x1);