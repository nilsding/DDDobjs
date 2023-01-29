// Ender3 webcam mount for a Logitech B905/C905 webcam
// --> the small part that screws onto the webcam
//
// SPDX-FileCopyrightText: 2023 Georg Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

include <../vendor/BOSL2/std.scad>

/* [Hidden] */
width = 18;
hole_diameter = 5;

diff()
cuboid(
  [width, 9, 6],
  rounding = width / 2,
  edges = [FRONT+LEFT, FRONT+RIGHT],
  $fn = 100,
  anchor = BOTTOM+LEFT+FRONT
) {
  tag("remove")
  fwd(1)
  attach(TOP, overlap = 11)
  cyl(h = 11 + 1, d = hole_diameter, center = false);

  diff("yeet")
  attach(BACK)
  cuboid(
    [width / 2, 6, 7],
    rounding = 6 / 2,
    edges = [FRONT+UP, BACK+UP],
    $fn = 100,
    anchor = BOTTOM+RIGHT
  ) {
    // yeet a hole where the camera slides in
    tag("yeet")
    left(1.5)
    up(1.2)
    cuboid(
      [7, 4.2, 3.2],
      rounding = 4.2 / 2,
      edges = [FRONT+UP, BACK+UP],
      $fn = 50,
      anchor = FRONT+BACK+LEFT
    );

    // yeet a hole where the screwhead fits
    tag("yeet")
    attach(LEFT)
    back(1)
    cyl(h = 5, d = 3.5);

    // yeet a hole where the screw can go through
    tag("yeet")
    attach(LEFT)
    back(1)
    cyl(h = width, d = 1.5);
  }
}
