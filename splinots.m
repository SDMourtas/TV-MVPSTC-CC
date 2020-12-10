function f = splinots(data,d,t)
%  The function splinots(data,d,t) (splinots standing for spline
%  interpolation of time series) returns interpolated values of a function
%  of n variables at specific query points using cubic spline interpolation.
%
%  INPUT:
%
%           data = A column vector or matrix which contains the time series
%                  values.
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
%           cubic spline interpolation of each number of the input vector.

rf = fix(t);
if t>size(data,1)-1
    f=data(end,:);
elseif rf==t
    f=data(t+1,:);
else
    del = data(rf+2,:)-data(rf+1,:); 
    dzz = (del-d(rf+1,:)); dzx = (d(rf+2,:)-del);
    f = (dzx-dzz)*(t-rf)^3 +(2*dzz-dzx)*(t-rf)^2 ...
            +d(rf+1,:)*(t-rf)+data(rf+1,:);
end