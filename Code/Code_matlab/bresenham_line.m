% AUTHOR    :CHANDAN KUMAR 
% TITLE     :BRESENHAM LINE ALGORITHM
% SUBJECT   :COMPUTER GRAPHICS AND SOLID MODELLING
% DISCLAIMER:CODE DRAWS A LINE USING BRESENHAM LINE ALGORITHM.

%function [x_coord, y_coord] = bresenham_line(point)
function [x_coord, y_coord] = bresenham_line(point)
%clc
%clear all
%point = input('Give coord[ x0 y0 x1 y1]: ');
%if (abs(point(4)-point(2)) > abs(point(3)-point(1)))       % If the line is steep                                
%  x0 = point(2);y0 = point(1); x1 = point(4);y1=point(3);% then it would be converted to 
%    token =1;                                              % non steep by changing coordinate
%else
%    x0 = point(1);y0 = point(2); x1 = point(3);y1=point(4);
%    token = 0; 
%end
%if(x0 >x1)
%    temp1 = x0; x0 = x1; x1 = temp1;
%    temp2 = y0; y0 = y1; y1 = temp2;
%end
x0 = point(1);
y0 = point(2);
x1 = point(3);
y1 = point(4);
%dx = abs(x1 - x0) ;                              % Distance to travel in x-direction
dx = x1 - x0 ;                              % Distance to travel in x-direction
%dy = abs(y1 - y0);                               % Distance to travel in y-direction
dy = y1 - y0;                               % Distance to travel in y-direction
sx = sign(x1 - x0);                              % sx indicates direction of travel in X-dir
sy = sign(y1 - y0);                              % Ensures positive slope line

%clf, subplot(2,1,1) ,hold on , grid on ,axis([x0-1 x1+1 y0-1 y1+1]);
%title('Bresenham Line Generation Algorithm: Point form')
x = x0; y = y0;                                  % Initialization of line
param = 2*dy - dx ;                              % Initialization of error parameter
for i = 0:dx-1                                   % FOR loop to travel along X
    x_coord(i+1) = x;                            % Saving in matrix form for plot
    y_coord(i+1) = y;
    %if (token ==0)                               % Plotting in point form 
        %plot(x,y,'r*');                          % For steep line coordinate is again
    %else                                         % converted for actual line drawing.
        %plot(y,x,'r*');
    %end
    param = param + 2*dy;                        % parameter value is modified
    if (param >0)                                % if parameter value is exceeded
        y = y +1*sy;                             % then y coordinate is increased
        param = param - 2*(dx );                 % and parameter value is decreased
        
    end
    x = x + 1*sx;                                % X-coordinate is increased for next point
end
%subplot(2,1,2)                                   % Plotting in line fragment form
%if (token ==0)
%    plot(x_coord,y_coord,'r-','LineWidth',2);
%else
%    plot(y_coord,x_coord,'r-','LineWidth',2);
%end
%grid on
%axis([x0-1 x1+1 y0-1 y1+1]);
%title('Bresenham Line Generation Algorithm: Line fragment form')
