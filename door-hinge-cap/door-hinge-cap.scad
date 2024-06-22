// A cap for some door hinges.
//
// SPDX-FileCopyrightText: 2022 Jyrki Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

/* [General] */
innerCylinder = 10;
wallThickness = 3.5;
cylinderHeight = 22;

$fn = 72;

/* [Hidden] */
// ic -> innerCylinder
icDiam = innerCylinder + 2; // 2mm slack
icHeight = cylinderHeight;
// oc -> outerCylinder
ocDiam = innerCylinder + (wallThickness * 2);
ocHeight = cylinderHeight;

module cylinderCircleTop(d, h) {
  union() {
    cylinder(d = d, h = h);
    translate([0, 0, h])
      sphere(d = d);
  }
}


difference() {
  cylinderCircleTop(d = ocDiam, h = ocHeight);
  translate([0, 0, -1])
    cylinderCircleTop(d = icDiam, h = icHeight + 1);
}
