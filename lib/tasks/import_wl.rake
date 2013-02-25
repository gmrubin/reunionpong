#encoding: utf-8
require 'csv'
namespace :import_wl do
  desc "Add names to whitelist"
  task :create_wl => :environment do
    PATH = File.join(Dir.home, 'Dropbox','reunionpong')

    CSV.foreach(File.join(PATH, 'eights.csv')) do |row|
      puts row
      Whitelist.create!(email: row.first)
    end
  end
end
