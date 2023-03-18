#!/usr/bin/env ruby
# frozen_string_literal: true

# SPDX-FileCopyrightText: 2023 Georg Gadinger <nilsding@nilsding.org>
# SPDX-License-Identifier: AGPL-3.0

require "bundler"
Bundler.setup :default

require_relative "./config"

require "lastfm"
require "json"

lastfm = Lastfm.new(API_KEY, API_SECRET)

from_uts = Time.utc(YEAR).to_i
to_uts = Time.utc(YEAR + 1).to_i

all_tracks = []

track_cache = "tracks_#{USER_NAME}_#{YEAR}.json"
if File.exist?(track_cache)
  all_tracks = JSON.parse(File.read(track_cache))
else
  page = 1
  loop do
    puts "get tracks for #{USER_NAME} in #{YEAR} ... page #{page}"
    begin
      tracks = lastfm.user.get_recent_tracks(user: USER_NAME, limit: 200, from: from_uts, to: to_uts, page:)
    rescue Lastfm::ApiError => e
      puts "#{e.message} -- retrying in 1s"
      sleep 1
      retry
    end

    break unless tracks

    all_tracks.concat(tracks)
    page += 1
  end

  File.open(track_cache, "w") do |f|
    f.puts JSON.pretty_generate all_tracks
  end
end

scrobbles_per_day =
  all_tracks
  .map { Time.at(_1.dig("date", "uts").to_i).strftime("%Y-%m-%d") }
  .tally

max_scrobbles = scrobbles_per_day.values.max.to_f

scrobbles_per_day_heights =
  scrobbles_per_day
  .map { |date, count| [date, ((count / max_scrobbles) * 10).ceil] }
  .to_h

every_day =
  (from_uts...to_uts)
  .step(3600 * 24)
  .map { time = Time.at(_1); date = time.strftime("%Y-%m-%d"); [time, scrobbles_per_day_heights.fetch(date, 0)] }
  .to_h

columns = [Array.new(7, 0)]
last_wday = 0

every_day.each do |time, heights|
  columns << Array.new(7, 0) if last_wday == 6 # add new column if the last weekday was a saturday

  last_wday = time.wday
  columns.last[last_wday] = heights
end

File.open("data.scad", "w") do |f|
  f.puts "// generated by gen_skyline_data.rb"
  f.puts
  f.puts "data_year = #{YEAR.to_s.inspect};"
  f.puts "data_username = #{USER_NAME.inspect};"
  f.puts "data_columns = #{columns.inspect};"
end