close all;
clear all;

% source of signal transmision
txPower = 10 * log10(10); % dBW
frequance = 2.4 * 1000000; % kHz

% source of signal transmision
transmiters = [
    % x  ,   y  ,  tx_power, tx_frequency
    1000, 1000, txPower, frequance;
    200, 800, txPower, frequance;
    500, 1900, txPower, frequance;
    
];

% Definig room space  - in centymeters [cm]
roomSpace = [2000, 2000];  % x, y

% Definig walls which will block our signal - in centymeters [cm]
walls = [
    % x_start, x_end, y_start, y_end
    900,700,200,400;        % wall no. 1
    1900,1500,800,1200;        % wall no. 2
    1000,80,1800,900;    % wall no. 3
    300,80,700,180;
];

% Function that visualize our room
room = figure;
% GRAPH ---------------------------------
hold on
figure(room); createWallDrawing(walls, roomSpace, transmiters, 1)
% GRAPH ---------------------------------

% specifies when calculation will be performed by x cm
step = 10 ;

% This value should be set to -inf but for displaying scatter plot purposes we cannot put it here.
% To create a better output, run the code multipe time and find out which value best fits the graph
scale_min = -55;

% FSPL (Free space path loss) mesh can input multiple transmitters
% this function do not support reflections
% max_power will allways return  inf because fspl is Inf inside transmiter
% (no path loss)
% ---------------------------------------------
%[mesh,min_power, max_power] = fsplMesh(transmiters, roomSpace, walls, step, scale_min);
% ---------------------------------------------

% UNDER CONSTRUCTION -> guffy output
% ---------------------------------------------
[mesh, min_power, max_power] = rayTracingMesh(transmiters, roomSpace, walls, step, scale_min);
% ---------------------------------------------


% GRAPH FOR STUFF  BEFORE THIS LINE ^^^^^^^
figure;surf(mesh);shading('interp');colorbar

            %figure;            %  the same ^
            %surf(mesh)
            %shading('interp')
            %colorbar

% Determinate signal strenght using raytrancing on moving object

% this value specify how many time signal need to reflect
reflectionNumber = 1;

% this value determines how the signal will decrease during wall reflection
reflection_factor = 0.7;

% time symimulated data
syms t

moveing_object = [
    % x_start, y_start, x_speed, y_speed,
    %  [cm]    [cm]      [cm/s]   [cm/s]
    0  ,    1200,       500*t,   200*t
    500  ,    500,       500*t,   (300*t + 150^t) 
];
outputTimeBoundries = [
    % time_start, time_end
        1,         2000
];
time_step = 10; % calculate every X ms

% GRAPH ---------------------------------
%figure(room); createPathMovingObj(roomSpace, moveing_object, outputTimeBoundries, time_step);
%hold off;
% GRAPH ---------------------------------

% ---------------------------------------------
%[object_values, min_power, max_power] = rayTSignalStrMoveingObj(transmiters, roomSpace, walls, moveing_object, time_step, outputTimeBoundries, reflection_factor, scale_min)

%length(object_values)
%length(outputTimeBoundries(1):time_step:outputTimeBoundries(2))
% GRAPH ---------------------------------
%figure;hold on;
%for num_mv_obj = 1 : size(object_values)
%    plot(outputTimeBoundries(1):time_step:outputTimeBoundries(2),object_values(num_mv_obj, :))
%end
% GRAPH ---------------------------------

