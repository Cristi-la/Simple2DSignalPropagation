function [mesh,min_power, max_power] = rayTracingMesh(transmiters, roomSpace, walls, step, scale_min)

c = 3 * 10^8

min_v = Inf
max_v = -Inf
mesh_test = [];


for y = 0 : step :roomSpace(1)
    x_line = [];
    for x = 0 : step : roomSpace(2)
        
        signal_strenght = 0;

        for i = 1 : size(transmiters)
            signal_reaches = 1;


            active_tx = transmiters(i, :);
            for l = 1 : size(walls)

                result = vectorCross(active_tx(1), active_tx(2), x, y, walls(l, 1), walls(l, 3), walls(l, 2), walls(l, 4));

                if (result ~= -1)
                    signal_reaches = 0;
                    break;
                end
            end
            
            if (signal_reaches == 1)
                
                lambda = c / active_tx(4) * 1000; % "* 1000" because of kHz to Hz

                r = sqrt((active_tx(1)-x)^2+(active_tx(2)-y)^2) / 100;
                H = (lambda * exp((2 * pi * r) / (lambda) ) ) / (4 * pi * r);
                signal_strenght = signal_strenght + active_tx(3) * H * H;
            end
        end

        if (signal_strenght==0)
            x_line = [x_line, scale_min];
        else
            if (min_v > signal_strenght)
                min_v = signal_strenght;
            end
            if (max_v < signal_strenght)
                max_v = signal_strenght;
            end
            
            x_line = [x_line, signal_strenght];
            
        end
    end
    mesh_test = [mesh_test; x_line];
end

max_power = max_v
min_power = min_v
mesh = mesh_test;


