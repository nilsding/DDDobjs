// simple squeezing utility for these Hello Fresh sauce packets
//
// SPDX-FileCopyrightText: 2023 Jyrki Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

// an usual packet is less than 7cm wide
width = 70;
// 1.5mm should be enough to fit a packet
hole_width = 1.5;
height = 7;
margin = 3;

difference() {
  cube([width + margin * 3, margin * 3 + hole_width, height]);
  translate([margin * 3 / 2, margin * 3 / 2, -(height / 2)])
  cube([width, hole_width, height * 2]);
}
