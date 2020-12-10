function f = splinotss(sdata,d,t)
%  The function splinotss(data,d,t) (splinotss standing for spline 
%  interpolation of time series) returns interpolated values of a 1-D 
%  function at specific query points using cubic spline interpolation.
%
%  INPUT:
%
%           data = An array structure which contains the time series values.
%
%           d = the piecewise polynomial of the cubic spline interpolant of 
%               the data values.
%
%           t = A real number or a column vector which is consist with real 
%               numbers. Those numbers are the coordinates of the query 
%               points.
%
%  OUTPUT: 
%
%           The cubic spline interpolation of the inputted number or the
%           cubic spline interpolation of each number of the input structure.

k=length(sdata);
rf = fix(t);
if t>k-1
    f=sdata{k};
elseif rf==t
    f=sdata{rf+1};
else
    del = sdata{rf+2}-sdata{rf+1}; 
    dzz = (del-d{rf+1}); dzx = (d{rf+2}-del);
    f = (dzx-dzz)*(t-rf)^3 +(2*dzz-dzx)*(t-rf)^2 ...
            +d{rf+1}*(t-rf)+sdata{rf+1};
end