// A handle for the coffee funnel of Bialetti Moka Express pots
//
// SPDX-FileCopyrightText: 2020, 2022 Jyrki Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

/* [General] */

// size of your moka pot.  select "custom" to use a custom size instead
variant = "6 cups"; // ["4 cups", "6 cups", "custom"]

/* [Handle] */

handle_height = 20;
handle_length = 100;
handle_width = 25;
handle_roundness = 5; // [0:9]

/* [Custom] */

// diameter of the funnel measured from the top (in mm)
custom_diameter = 65;

/* [Hidden] */

diameter = (variant == "4 cups") ? 59
  : (variant == "6 cups") ? 65
  : custom_diameter;

outer_diameter = diameter + 5;
inner_diameter = diameter - 1;

$fn = 85;

module holder() {
  cylinder(handle_height, d = outer_diameter);
}

module handle() {
  translate([outer_diameter / 2 - (outer_diameter - inner_diameter) / 2 - handle_roundness, -(handle_width / 2) + handle_roundness, handle_roundness])
  minkowski() {
    cube([handle_length - handle_roundness * 2, handle_width - handle_roundness * 2, handle_height - handle_roundness * 2]);
    sphere(handle_roundness);
  }
}

difference() {
  union() {
    handle();
    holder();
  };
  translate([0, 0, -1])
  cylinder(handle_height + 2, d = inner_diameter);
}
