% =========================================================% 
% PBAS by V.N.Katsikis, S.D.Mourtas, P.S.Stanimirovic, S.Li, X.Cao
%
% based on K. Deb, Optimization for Engineering Design: Algorithms 
% 
% and Examples. PHI, second ed., July 2013.
% ======================================================== %

function [xbest,fbest] = PBAS(t,p,m,c,K,noep,x1)
% Penalty Algorithm for the Modified BAS Algorithm in the TV-MVPSTC-CC problem.

[xi_minus,xi_plus,A,b,pr,w]=problem(t,p,m,c,noep,x1);

% parameter setup
tol1 = 1e-4;       % tolerance or accuracy
tol2 = 1e-4;
R0 = 0.1;          % initial Penalty parameter
c = 1e2;
t = 1;
x=[];
x(:,t)= x1;
R(t)= R0;
s0 = @(u)sum((-A*u+b<0).*(-A*u+b)+(xi_minus-u>0).*(xi_minus-u) ...
    +(u-xi_plus>0).*(u-xi_plus)+(u-x1~=0).*(u-x1))+(sum(u>0)>K);
s = s0(x(:,t));
beet = @(w1,w2)BAS(w1,xi_minus,xi_plus,A,b,pr,w,K,w2,0.2,0.5,1200,1e-6);

if s > 0
    P(1,t) = penfun(x(:,t),xi_minus,xi_plus,A,b,pr,w,K,R(1,t),x1);
    G(:,t) = beet(x(:,t),R(1,t));
    x(:,t+1) = G(:,t);
    t = t+1;
    P(1,t) = penfun(G(:,t-1),xi_minus,xi_plus,A,b,pr,w,K,R(1,t-1),x1);
    err = abs(P(1,t));
    R(1,t) = c*R(1,t-1);
    x(:,t-1) = x(:,t);
else
    P(1,t) = penfun(x(:,t),xi_minus,xi_plus,A,b,pr,w,K,0,x1);
    G(:,t) = beet(x(:,t),0);
    t = t+1;
    P(1,t) = penfun(G(:,t-1),xi_minus,xi_plus,A,b,pr,w,K,0,x1);
    err = abs(P(1,t));
    R(1,t) = c*R(1,t-1);
    x(:,t) = G(:,t-1);
end

% iteration
xbest(1,:) = G(:,t-1);
while err > tol2
    G(:,t) = beet(x(:,t),R(1,t));
    x(:,t+1) = G(:,t);
    t = t+1;
    R(1,t) = c*R(1,t-1);
    P(1,t) = penfun(G(:,t-1),xi_minus,xi_plus,A,b,pr,w,K,R(1,t-1),x1);
    err = abs(P(1,t)-P(1,t-1));
    s = s0(x(:,t));
    xbest(1,:) = G(:,t-1);
    if abs(s) < tol1
        break
    elseif abs(x(:,t)-x(:,t-1)) < 10e-5
        break
    end
end
fbest = objfun(pr,w,xbest',x1);