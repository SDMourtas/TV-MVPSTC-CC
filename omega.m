%  The function omega(noep,t) returns the parameter omega which splits the 
%  observations to the time periods.
%
%  INPUT:
%
%           noep = the number of observations in each month as a vector of
%                  n prices.
%
%           t = A real number which represents the time.
%
%  OUTPUT: 
%
%           the parameter omega which splits the observations to the time 
%           periods.
%
% Citation details: --------------------------------------------------- %
% Reference: V.N. Katsikis, S.D. Mourtas, Predrag S. Stanimirovi?, 
%            Shuai Li, Xinwei Cao, "Time-varying minimum-cost portfolio 
%            insurance under transaction costs problem via Beetle Antennae 
%            Search Algorithm (BAS)", Applied Mathematics and Computation, 
%            385, 125453 (2020)                                  
% ---------------------------------------------------------------------- %
function o=omega(noep,t)
%if length(noep)==1
%    o=noep;
%elseif length(unique(noep))==1
%    o=noep(1)/length(noep);
%else
    rf=floor(t);
    if rf>0
        o=sum(noep(1:rf))-1;
    if t~=rf
        o=(o+noep(rf+1)*(t-rf))/t;
    else
        o=o/t;
    end
    else
        o=noep(1)-1;
    end
%end