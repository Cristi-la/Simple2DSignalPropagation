function interpoint = interX(x, xe, y, ye, d, de, g, ge)


a = [
    ((ye-y) / (xe-x));
    ((ge-g) / (de-d))
];

b = [
    (y - a(1)*x);
    (g - a(2)*d)
];

interpoint = inv([-a(1) 1 ; -a(2) 1]) * b;