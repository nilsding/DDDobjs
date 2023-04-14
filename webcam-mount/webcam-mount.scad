// Ender3 webcam mount for a Logitech B905/C905 webcam
// --> the thing that holds the camera on the Z axis
//
// SPDX-FileCopyrightText: 2023 Georg Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

include <../vendor/BOSL2/std.scad>

/* [Hidden] */
margin = 5;
screwhole_diameter = 3.5;

width = 40;
height = 30;
depth = 2;

mount_width = 18; // width of the mount itself
mount_height = 6; // height of the mount itself
mount_space = 10; // space between the holder on the webcam

module screwhole() {
  /* TODO: look for fitting screws and play around with this
  cyl(h = depth, d = screwhole_diameter, center = true) {
    attach(TOP, overlap = 1) cyl(h = 1, d1 = screwhole_diameter, d2 = screwhole_diameter + 2, center = false);
  };
  */
}

module webcam_mount() {
  hole_diameter = 5;

  tag_scope("webcam_mount")
  diff()
  cuboid(
    [18, 10, 11],
    rounding = 5,
    edges = [TOP+RIGHT, TOP+LEFT],
    $fn = 100,
    anchor = BOTTOM+LEFT
  ) {
    // hole for the screw to mount the webbed cam
    tag("remove")
    attach(BACK, overlap = 11)
    cyl(h = 11 + 1, d = hole_diameter, center = false);

    // space to mount the webbed cam
    tag("remove")
    up(1)
    back(1 - 0.5)
    cuboid([18 + 1, 6.5, 11]);
  };
}

diff()
cuboid(
  [width, height, depth],
  rounding = 5,
  edges = [BACK+LEFT, BACK+RIGHT],
  $fn = 100,
  anchor = BOTTOM+LEFT+FRONT
) {
  tag("remove") fwd(margin) right(margin) position(BACK+LEFT)  screwhole();
  tag("remove") fwd(margin) left(margin)  position(BACK+RIGHT) screwhole();

  extension_height = 9;
  // extended base of 5mm
  fwd(height / 2) attach(TOP) cuboid(
    [width, extension_height, 5],
    anchor = FRONT+BOTTOM,
    rounding = 1,
    edges = [TOP+RIGHT]
  ) {
    // 45mm long rod for camera
    left(45 / 2 - 5 / 2) attach(TOP) cuboid(
      [5, extension_height, 45],
      anchor = BOTTOM+LEFT,
      rounding = 1,
      edges = [TOP+LEFT]
    ) {
      // add a nice rounded corner to it
      diff("yeet")
      right(5 / 2)
      attach(BOTTOM)
      cuboid([10, extension_height, 10], anchor = TOP+RIGHT) {
        tag("yeet")
        cuboid([10, extension_height + 1, 10], rounding = 10, edges = [TOP+RIGHT]);
      };

      // attach the webcam mount
      right(5 / 2)
      back(0.5) // TODO: figure out how to get there by just looking at extension_height or how to make it flush with the bottom
      attach(TOP)
      orient(RIGHT)
      webcam_mount();

      // add a little wedge
      right(1 / 2)
      attach(TOP)
      orient(LEFT)
      attach(BACK)
      wedge([18, 5 - 1, 1], anchor = BOTTOM+LEFT);
    }
  }
};
