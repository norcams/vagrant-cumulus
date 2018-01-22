# lib/vagrant-cumulus.rb

require 'vagrant-cumulus/plugin'

module VagrantPlugins
  module GuestCumulus
    # This returns the path to the source of this plugin.
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end

