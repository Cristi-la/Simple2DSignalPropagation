function createWallDrawing(walls, roomSpace, transmiter, smallOutPut)

    hold on;
    for i = 1 : size(transmiter)
        active_tx = transmiter(i, :);
        plot(active_tx(1),active_tx(2),'r*');
    end
    line([0 roomSpace(1)], [0 0])
    line([0 0], [0 roomSpace(2)])
    line([roomSpace(1), roomSpace(1)], [0 roomSpace(2)])
    line([0 roomSpace(1)], [roomSpace(2) roomSpace(2)])

    for i = 1 : size(walls)
        line([walls(i, 1), walls(i, 2)], [walls(i, 3), walls(i, 4)]);
    end
end