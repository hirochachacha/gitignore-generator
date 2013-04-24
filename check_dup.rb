#!/usr/bin/env ruby
#coding: utf-8

require 'find'
require 'pathname'

GLOBAL = {}

def dir
  File.dirname(__FILE__)
end

def check_global
  Find.find("#{dir}/Global") do |f|
    if f.end_with?(".gitignore") && !Pathname.new(f).symlink?
      open(f, 'r').each do |line|
        line = line.strip
        if GLOBAL.include?(line) && (Pathname.new(GLOBAL[line]).parent != Pathname.new(f).parent)
          STDERR.puts "Dupulication Detected: #{line}\n  between\n    #{GLOBAL[line]}\n  and\n    #{f}"
          STDERR.puts ""
        else
          unless line.empty? || line.start_with?("#")
            GLOBAL[line] = f
          end
        end
      end
    end
  end
end

def check_language
  Dir.foreach("#{dir}/Language").drop(2).each do |lang|
    local = {}
    Find.find("#{dir}/Language/#{lang}") do |f|
      if f.end_with?(".gitignore") && !Pathname.new(f).symlink?
        open(f, 'r').each do |line|
          line = line.strip
          if local.include?(line) && (Pathname.new(local[line]).parent != Pathname.new(f).parent)
            STDERR.puts "Dupulication Detected: #{line}\n  between\n    #{local[line]}\n  and\n    #{f}"
            STDERR.puts ""
          elsif GLOBAL.include?(line)
            STDERR.puts "Dupulication Detected: #{line}\n  between\n    #{GLOBAL[line]}\n  and\n    #{f}"
            STDERR.puts ""
          else
            unless line.empty? || line.start_with?("#")
              local[line] = f
            end
          end
        end
      end
    end
  end
end

check_global
check_language
