#!/usr/bin/env rake
# frozen_string_literal: true

# SPDX-FileCopyrightText: 2023 Georg Gadinger <nilsding@nilsding.org>
# SPDX-License-Identifier: MIT

OPENSCAD_COMMAND = ENV.fetch("OPENSCAD", "openscad")

task :default => FileList["**/*.scad"].exclude(
  %r{/data.scad$},
  %r{^vendor/},
  %r{^tmp/},
).ext("stl") do
  $stderr.puts "\033[32;1mAll good.\033[0m"
end

rule ".stl" => ".scad" do |t|
  $stderr.puts "\033[34;1m====[ #{t.name} ]====\033[0m"
  sh OPENSCAD_COMMAND, "-o", t.name, t.source
end

file "lastfm-skyline/data.scad" do |t|
  $stderr.puts "\033[35;1m====[ #{t.name} ]====\033[0m"
  Dir.chdir "lastfm-skyline" do
    sh "bundle"
    sh "ruby", "gen_skyline_data.rb"
  end
end

file "lastfm-skyline/lastfm-skyline.stl" => "lastfm-skyline/data.scad"
