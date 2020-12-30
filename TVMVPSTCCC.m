% =========================================================% 
% The TV-MVPSTC-CC problem setup and main procedure
%
% by V.N.Katsikis, S.D.Mourtas, P.S.Stanimirovic, S.Li, X.Cao
% ======================================================== %
function [t,xbas,xfa,xde]=TVMVPSTCCC(X,tspan,div,mavgt,inter,s,K,xp,noep)

t=tspan(1):1/div:tspan(2);
tot=length(t);
[m,n]=size(X);

% Moving average type
Xm=movavg(X,mavgt,s); 
Xm=Xm(s+1:end,:);
Xc{m-s,1}={};
for i=1:m-s
    Xc{i,1}=cov(X(i:s+i-1,:));
end

% Data interpolation
if strcmp(inter,'pchip')
    p=@(x)pchinots(X(s+1:end,:),x)';
    c=@(x)pchinotss(Xc,x);
    m=@(x)pchinots(Xm,x)';
elseif strcmp(inter,'spline')
    spl1 = sp(X(s+1:end,:));
    p = @(x)splinots(X(s+1:end,:),spl1,x)';
    spl = sp(Xm);
    m = @(x)splinots(Xm,spl,x)';
    spls = sps(Xc);
    c = @(x)splinotss(Xc,spls,x);
else
    p=@(x)linots(X(s+1:end,:),x)';
    c=@(x)linotss(Xc,x);
    m=@(x)linots(Xm,x)';    
end

% BAS solutions
xbas=zeros(n,tot);fbas=zeros(1,tot);
tic
[xbas(:,1),fbas(1)]=PBAS(t(1),p,m,c,K,noep,xp);
for i=2:tot
    [xbas(:,i),fbas(i)]=PBAS(t(i),p,m,c,K,noep,xbas(:,i-1));
end
fprintf('BAS:')
toc
for i=1:n
subplot(n,1,i);plot(t,xbas(i,:),'b');hold on
ylabel(['\eta_{',num2str(i),'}(t)']);
end

% FA solutions
xfa=zeros(n,tot);ffa=zeros(1,tot);
tic
[xi_minus,xi_plus,A,b,pr,w]=problem(t(1),p,m,c,noep,xp);
xfa(:,1)=fa_ndim_new(A,pr,b,w,K,xi_minus',xi_plus',xp)';
ffa(1)=objfun(pr,w,xfa(:,1),xp);
for k=2:tot
[xi_minus,xi_plus,A,b,pr,w]=problem(t(k),p,m,c,noep,xfa(:,k-1));
xfa(:,k)=fa_ndim_new(A,pr,b,w,K,xi_minus',xi_plus',xfa(:,k-1))';
ffa(k)=objfun(pr,w,xfa(:,k),xfa(:,k-1));
end
fprintf('FA:')
toc
for i=1:n
subplot(n,1,i);plot(t,xfa(i,:),':r');hold on
end

% DE solutions
xde=zeros(n,tot);fde=zeros(1,tot);
tic
[xi_minus,xi_plus,A,b,pr,w]=problem(t(1),p,m,c,noep,xp);
xde(:,1)=de(A,pr,b,w,K,xp,xi_minus',xi_plus')';
fde(1)=objfun(pr,w,xde(:,1),xp);
for k=2:tot
[xi_minus,xi_plus,A,b,pr,w]=problem(t(k),p,m,c,noep,xde(:,k-1));
xde(:,k)=de(A,pr,b,w,K,xde(:,k-1),xi_minus',xi_plus')';
fde(k)=objfun(pr,w,xde(:,k),xde(:,k-1));
end
fprintf('DE:')
toc
for i=1:n
subplot(n,1,i);plot(t,xde(i,:),'-.m');hold on
end

suptitle('Convergence of \eta(t)')
xlabel('Time')
legend('BAS','FA','DE')
hold off

% Figures
erxbas=zeros(1,tot);
erxfa=zeros(1,tot);
erxde=zeros(1,tot);
varxbas=zeros(1,tot);
varxfa=zeros(1,tot);
varxde=zeros(1,tot);
for i=1:tot
    erxbas(i)=xbas(:,i)'*m(omega(noep,t(i))*t(i));
    erxfa(i)=xfa(:,i)'*m(omega(noep,t(i))*t(i));
    erxde(i)=xde(:,i)'*m(omega(noep,t(i))*t(i));
    varxbas(i)=xbas(:,i)'*c(omega(noep,t(i))*t(i))*xbas(:,i);
    varxfa(i)=xfa(:,i)'*c(omega(noep,t(i))*t(i))*xfa(:,i);
    varxde(i)=xde(:,i)'*c(omega(noep,t(i))*t(i))*xde(:,i);
end

figure
plot(t,erxbas);hold on
plot(t,erxfa,':r')
plot(t,erxde,'-.m')
ylabel('Expected Return')
xlabel('Time')
xticklabels({'1/8','3/9','1/10','1/11','2/12','2/1','3/2'})
legend('BAS','FA','DE')
hold off

figure
plot(t,varxbas);hold on
plot(t,varxfa,':r')
plot(t,varxde,'-.m')
ylabel('Variance')
xlabel('Time')
xticklabels({'1/8','3/9','1/10','1/11','2/12','2/1','3/2'})
legend('BAS','FA','DE')
hold off

figure
plot(t,abs(fbas-varxbas));hold on
plot(t,abs(ffa-varxfa),':r')
plot(t,abs(fde-varxde),'-.m')
ylabel('Transaction Cost')
xlabel('Time')
xticklabels({'1/8','3/9','1/10','1/11','2/12','2/1','3/2'})
legend('BAS','FA','DE')
hold off