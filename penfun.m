function P = penfun(x,s_minus,s_plus,A,b,pr,w,K,R,x1)
% R * constraint function
f = R*sum((-A*x+b<0).*(-A*x+b).^2+(s_minus-x>0).*(s_minus-x).^2 ...
    +(x-s_plus>0).*(x-s_plus).^2)+R^2*(sum(x>0)>K);
% Objective function
P = objfun(pr,w,x,x1)+f;  
end