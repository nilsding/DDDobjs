// a thing that hopefully holds up certain art prints on a wall
//
// SPDX-FileCopyrightText: 2023 Georg Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

include <../vendor/BOSL2/std.scad>

width = 25;
height = 180;
// thickness of the print -- add 0.5mm to it so it fits snugly
picture_depth = 3.5;
hole_diameter = 5;
/* [Hidden] */
base = 2;
// thickness of the frame itself, 2mm seems to be enough
frame_depth = 2;
// how much the frame should overlap to the front
front_extend = 15;

roundness = 1.5;

$fn = 50;

// bottom
cuboid(
  [width, base, picture_depth + frame_depth * 2],
  rounding = roundness,
  except = [BACK],
  anchor = BOTTOM+BACK
) {

  // front
  position(TOP+BACK)
  cuboid(
    [width, front_extend, frame_depth],
    rounding = roundness,
    except = [FRONT, BOTTOM],
    anchor = TOP+FRONT
  );

  // rear
  diff("yeet")
  position(BOTTOM+BACK)
  cuboid(
    [width, height - base, frame_depth],
    rounding = roundness,
    except = [FRONT, TOP],
    anchor = BOTTOM+FRONT
  ) {
    // hole
    tag("yeet")
    fwd(hole_diameter + 10)
    position(BACK)
    cylinder(d = hole_diameter, h = frame_depth * 2, anchor = FRONT);
  }
}
