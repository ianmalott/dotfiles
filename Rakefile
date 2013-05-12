require 'fileutils'
require 'rake'

# Overview
#
#   This rake task automates dotfile symlinking.
#   It extracts the names of dotfiles from Linkfile.
#   It then creates symlinks in the home directory that point to those dotfiles.
#
# Usage
#
#   git clone <dotfiles repository> ~/.dotfiles
#   cd ~/.dotfiles
#   rake install
#
# Inspiration
#
#   https://github.com/ryanb/dotfiles
#   https://github.com/holman/dotfiles

desc 'Install dotfiles into home directory'
task :install do
  replace_all = false

  Dotfile.chosen_for_symlinking.each do |dotfile|
    if File.symlink?(dotfile.target)
      if File.identical?(dotfile.source, dotfile.target)
        puts "Desired symlink already exists (#{dotfile.target} -> #{dotfile.source})"
      elsif replace_all
        dotfile.symlink_target_to_source overwrite: true
      else
        print "Overwrite #{dotfile.target}? [ynaq] "
        case $stdin.gets.chomp
        when 'a' then replace_all = true; dotfile.symlink_target_to_source overwrite: true
        when 'y' then dotfile.symlink_target_to_source overwrite: true
        when 'q' then exit
        else puts "Skipping #{dotfile.target}"
        end
      end
    elsif File.exist?(dotfile.target)
      puts "Not symlinking #{dotfile.target} -> #{dotfile.source}; #{dotfile.target} exists and is not a symlink"
    else
      dotfile.symlink_target_to_source
    end
  end
end

desc 'Uninstall dotfiles from home directory'
task :uninstall do
  Dotfile.chosen_for_symlinking.each do |dotfile|
    if File.symlink?(dotfile.target)
      puts "Removing #{dotfile.target}"
      File.delete dotfile.target
    elsif File.exist?(dotfile.target)
      puts "Not removing #{dotfile.target}; it is not a symlink"
    else
      puts "No file to remove at #{dotfile.target}"
    end
  end
end

class Dotfile
  attr_reader :source, :target

  def initialize(source)
    @source = "#{Dir.pwd}/#{source}"
    @target = "#{Dir.home}/.#{source}"
  end

  def self.chosen_for_symlinking
    IO.readlines('Linkfile').map { |line| Dotfile.new line.chomp }
  end

  def symlink_target_to_source(options = {})
    if File.exist?(source)
      if File.exist?(target) || File.symlink?(target) && options[:overwrite]
        puts "Overwriting existing #{target} and linking to #{source}"
        FileUtils.rm_rf target
      else
        puts "Linking #{target} -> #{source}"
      end

      File.symlink source, target
    else
      puts "Cannot link to missing source: #{source}"
    end
  end
end
