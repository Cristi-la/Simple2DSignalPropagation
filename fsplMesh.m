function [mesh,min_power, max_power] = fsplMesh(transmiter, roomSpace, walls, step, scale_min)

min_v = Inf
max_v = -Inf
mesh_test = [];

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
                r = sqrt((active_tx(1)-x)^2+(active_tx(2)-y)^2) / 100;
                fspl = -87.55 + 20*log10(r) + 20*log10(active_tx(4));
                signal_power = signal_power + ( active_tx(3) - fspl);
            end
        end

        if (signal_power==0)
            x_line = [x_line, scale_min];
        else
            if (min_v > signal_power)
                min_v = signal_power;
            end
            if (max_v < signal_power)
                max_v = signal_power;
            end
            
            x_line = [x_line, signal_power];
            
        end
    end
    mesh_test = [mesh_test; x_line];
end

max_power = max_v;
min_power = min_v;
mesh = mesh_test;


