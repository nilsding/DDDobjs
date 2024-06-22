// SPDX-FileCopyrightText: 2023 Jyrki Gadinger <nilsding@nilsding.org>
// SPDX-License-Identifier: CC-BY-NC-SA-4.0

include <../vendor/BOSL2/std.scad>

include <data.scad>

// Use last.fm logo
lastfm_logo = true;

// Custom prefix for username (only used without a logo)
username_prefix = "last.fm/user/";

/* [Hidden] */
block_width = 2.5;

skyline_length = block_width * 53;
skyline_width = block_width * 7;

base_height = 10;
base_padding = block_width;
base_width = skyline_width + 2 * base_padding;
base_length = skyline_length + 2 * base_padding;
base_width_bottom = base_width + 5;
base_length_bottom = base_length + 5;

$fn = 50;

module skyline() {
  left(skyline_length / 2)
  back(skyline_width / 2)
  rot(-90)
  for (i = idx(data_columns)) {
    column = data_columns[i];
    back(block_width * i)
    for (j = idx(column)) {
      if (column[j] > 0) {
        right(block_width * j)
        cube([block_width, block_width, block_width * column[j]]);
      }
    }
  }
}

module username() {
  if (lastfm_logo) {
    fwd(4.5)
    linear_extrude(1)
    scale((base_height - 4) / 110)
    import("lastfm.svg");

    right(13)
    text3d(data_username, h = 1, size = base_height - 5, anchor = BOTTOM+LEFT);
  } else {
    text3d(str_join([username_prefix, data_username]), h = 1, size = base_height - 5, anchor = BOTTOM+LEFT);
  }
}

prismoid([base_length_bottom, base_width_bottom], [base_length, base_width], h = base_height) {
  // skyline
  attach(TOP)
  skyline();

  // username
  left(base_length / 2 - block_width * 2)
  attach(FRONT)
  username();

  // year
  right(base_length / 2 - block_width * 2)
  attach(FRONT)
  text3d(data_year, h = 1, size = base_height - 5, anchor = BOTTOM+RIGHT);
}
