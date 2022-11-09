function createPathMovingObj(roomSpace, moveing_object, outputTimeBoundries, time_sep)

% time symimulated data
syms t

for i = 1 : size(moveing_object)
    time_path = [];
    full_path = [];
    mv_obj = moveing_object(i, :);

    for ms = outputTimeBoundries(1) : time_sep : outputTimeBoundries(2)
        x_t = mv_obj(1) + double(subs(mv_obj(3), t, ms / 1000));
        y_t = mv_obj(2) + double(subs(mv_obj(4), t, ms / 1000));

        time_path = [time_path; x_t, y_t];
        if x_t >= roomSpace(1) || y_t >= roomSpace(2)
            break;
        end
    end

    for ms = 0 : time_sep : inf
        x_t = mv_obj(1) + double(subs(mv_obj(3), t, ms / 1000));
        y_t = mv_obj(2) + double(subs(mv_obj(4), t, ms / 1000));

        full_path = [full_path; x_t, y_t];

        if x_t >= roomSpace(1) || y_t >= roomSpace(2)
            break;
        end
    end
    hold on
    plot(full_path(:, 1),full_path(:, 2),'.');
    plot(time_path(:, 1),time_path(:, 2),'.'); 
end

%dx1db = diff(x1, b_sym);
%dx1db_solved = double(subs(dx1db, b_sym, b));
return;


    

line([0 roomSpace(1)], [0 0])
line([0 0], [0 roomSpace(2)])
line([roomSpace(1), roomSpace(1)], [0 roomSpace(2)])
line([0 roomSpace(1)], [roomSpace(2) roomSpace(2)])

for i = 1 : size(walls)
    line([walls(i, 1), walls(i, 2)], [walls(i, 3), walls(i, 4)]);
end
