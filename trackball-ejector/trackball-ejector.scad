// Trackball ejector thingy for a Logitech MX Ergo
//
// SPDX-FileCopyrightText: 2022 Georg Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

$fn = 200;

base_height = 1.5;
plunger_height = 10;
plunger_diameter = 6;

union() {
  translate([0, 0, base_height])
    cylinder(h = plunger_height, d = plunger_diameter);

  cylinder(h = base_height, d = plunger_diameter + 5);

  translate([0, 0, base_height + plunger_height])
    sphere(d = plunger_diameter);
}
