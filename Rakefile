require 'fileutils'
require 'rake'

# Overview
#
#   This rake task automates dotfile symlinking.
#   It looks for dotfiles in the pwd that end in .symlink.
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

  Dotfile.marked_for_symlinking.each do |dotfile|
    if File.exist?(dotfile.target)
      if File.identical?(dotfile.source, dotfile.target)
        puts "Identical #{dotfile.target} exists"
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
    else
      dotfile.symlink_target_to_source
    end
  end
end

desc 'Uninstall dotfiles from home directory'
task :uninstall do
  Dotfile.marked_for_symlinking.each do |dotfile|
    if File.exist?(dotfile.target)
      puts "Removing #{dotfile.target}"
      File.delete dotfile.target
    end
  end
end

class Dotfile
  SYMLINK_SUFFIX = '.symlink'

  attr_reader :basename, :source

  def initialize(source)
    @basename = File.basename(source, SYMLINK_SUFFIX)
    @source = source
  end

  def self.marked_for_symlinking
    filenames_with_symlink_suffix = Dir.glob("#{Dir.pwd}/*#{SYMLINK_SUFFIX}")
    filenames_with_symlink_suffix.map { |filename| Dotfile.new filename }
  end

  def symlink_target_to_source(options = {})
    if options[:overwrite]
      puts "Removing existing #{target}"
      FileUtils.rm_rf target
    end

    puts "Linking #{target} -> #{source}"
    File.symlink source, target
  end

  def target
    "#{Dir.home}/.#{basename}"
  end
end
