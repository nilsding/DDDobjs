// SPDX-FileCopyrightText: 2024 Jyrki Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

include <../vendor/BOSL2/std.scad>
include <../vendor/BOSL2/threading.scad>

$fn = 50;

diameter = 9;
length = 15;

difference()
{
  threaded_rod(d = diameter, l = length, pitch = .6);
  move([0, 0, -(length / 2) + .7])
  cylinder(d = diameter - 1.5, l = length);
}
