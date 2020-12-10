function d = sp(data)
%  The function sp(data) returns the piecewise polynomial of the cubic 
%  spline interpolant of the data values, when the data is in vector or 
%  matrix form.

data=data'; 
[m,n]=size(data);
del = data(:,2:end)-data(:,1:end-1); 
bb=zeros(m,n);
bb(:,2:n-1)=3*(del(:,1:n-2)+del(:,2:n-1));
bb(:,1)=(5*del(:,1)+del(:,2))/2;
bb(:,n)=(del(:,n-2)+5*del(:,n-1))/2;
dxt = ones(n-2,1);
c = spdiags([2 1 0;dxt 4*dxt dxt;0 1 2],[-1 0 1],n,n);
d=(bb/c)';