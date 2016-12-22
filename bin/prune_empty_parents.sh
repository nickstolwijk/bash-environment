#!/usr/bin/env ruby
old_parents = gets.chomp.gsub("-p ", " ")
new_parents = old_parents.empty? ? [] : `git show-branch --independent #{old_parents}`.split
puts new_parents.map{|p| "-p " + p}.join(" ")
