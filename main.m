close all;
clear all;

txPower = 10 * log10(10); % dBW
frequance = 2.4 * 1000000; % kHz

transmiter = [
    % x  ,   y  ,  power
    1000, 1000, txPower, frequance;
    200, 800, txPower, frequance;
    500, 1900, txPower, frequance;
    
];

roomSpace = [ 2000, 2000];  % x, y

walls = [
    % x_start, x_end, y_start, y_end
    900,700,200,400;        % wall no. 1
    1900,1500,800,1200;        % wall no. 2
    1000,80,1800,900;    % wall no. 3
    300,80,700,180;
];


%createWallDrawing(walls, roomSpace, transmiter, 1)

mesh_test = [];

step = 10 ;


min_power = 0;
for y = 0 : step :roomSpace(1)
    x_line = [];
    for x = 0 : step : roomSpace(2)
        
        signal_power = 0;

        for i = 1 : size(transmiter)
            signal_reaches = 1;

            active_tx = transmiter(i, :);
            for l = 1 : size(walls)

                result = vectorCross(active_tx(1), active_tx(2), x, y, walls(l, 1), walls(l, 3), walls(l, 2), walls(l, 4));

                if (result ~= -1)
                    signal_reaches = 0;
                    break
                end
            end
            
            if (signal_reaches == 1)
                r = sqrt((active_tx(1)-x)^2+(active_tx(2)-y)^2); 
                fspl = -87.55 + 20*log10(r) + 20*log10(active_tx(4));
                signal_power = signal_power + ( active_tx(3) - fspl);
            end
        end

        if (signal_power==0)
            x_line = [x_line, -300];
        else
            if (min_power > signal_power)
                min_power = signal_power;
            end
            x_line = [x_line, signal_power];
            
        end
    end
    mesh_test = [mesh_test; x_line];
end

min_power
%for x = 1 : roomSpace / step
%    for y=1 : roomSpace /step
%        if (mesh_test(x, y) == 0 )
%            mesh_test(x, y) = min_power;
%        end
%    end
%end

surf(mesh_test)
shading('interp')
colorbar
