// thing.scad

od = 70; // outer diameter
id = 64; // inner diameter
hh = 20; // holder height

hl = 100; // handle length
hw = 25; // handle width
hr = 5;  // handle roundness

$fn = 85;

module holder() {
     cylinder(hh, d = od);
}

module handle() {
     translate([od / 2 - (od - id) / 2 - hr, -(hw / 2) + hr, hr])
          minkowski() {
          cube([hl - hr * 2, hw - hr * 2, hh - hr * 2]);
          sphere(hr);
     }
}

difference() {
     union() {
          handle();
          holder();
     };
     translate([0, 0, -1])
          cylinder(hh + 2, d = id);
}
