#!/usr/bin/env ruby
#coding: utf-8

require 'find'
require 'pathname'

def dir
  File.dirname(__FILE__)
end

def print_global
  Find.find("#{dir}/Global") do |f|
    if f.end_with?(".gitignore") && !Pathname.new(f).symlink?
      STDOUT.puts("#[#{f}]")
      open(f, 'r').each do |line|
        line = line.strip
        if !line.empty?
          STDOUT.puts(line)
        end
      end
      STDOUT.puts
    end
  end
end

def print_language(name)
  if name && !name.empty? && Pathname.new("#{dir}/Language/#{name}").directory?
    Find.find("#{dir}/Language/#{name}") do |f|
      if f.end_with?(".gitignore") && !Pathname.new(f).symlink?
        STDOUT.puts("#[#{f}]")
        open(f, 'r').each do |line|
          line = line.strip
          if !line.empty?
            STDOUT.puts(line)
          end
        end
      end
      STDOUT.puts
    end
  end
end

def print_language_names
  Dir.foreach("#{dir}/Language").drop(2).each do |f|
    STDOUT.puts(f)
  end
end
