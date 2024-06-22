#!/usr/bin/env rake
# frozen_string_literal: true

# SPDX-FileCopyrightText: 2023 Jyrki Gadinger <nilsding@nilsding.org>
# SPDX-License-Identifier: MIT

require "yaml"

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

  if File.exist?(t.source.ext("yml"))
    variants = YAML.load_file(t.source.ext("yml"))
    variants.each do |variant_name, params|
      new_filename = "#{t.name.ext}__#{variant_name}.stl"
      params_list = params.flat_map { |k, v| ["-D", "#{k}=#{v.inspect}"] }

      $stderr.puts "\033[34;1m====[ #{new_filename} ]====\033[0m"
      sh OPENSCAD_COMMAND, *params_list, "-o", new_filename, t.source
    end
  end
end

file "lastfm-skyline/data.scad" do |t|
  $stderr.puts "\033[35;1m====[ #{t.name} ]====\033[0m"
  Dir.chdir "lastfm-skyline" do
    sh "bundle"
    sh "ruby", "gen_skyline_data.rb"
  end
end

file "lastfm-skyline/lastfm-skyline.stl" => "lastfm-skyline/data.scad"
