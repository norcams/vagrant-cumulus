begin
  require 'vagrant'
rescue LoadError
  raise 'The vagrant-cumulus plugin must be run within Vagrant'
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < '1.7.0'
  fail 'The vagrant-cumulus plugin is only compatible with Vagrant 1.7+'
end

module VagrantPlugins
  module GuestCumulus
    class Plugin < Vagrant.plugin("2")
      name "Cumulus guest"
      description "Cumulus Linux guest support."

      guest("cumulus", "debian") do
        require_relative "guest"
        Guest
      end

      guest_capability("cumulus", "configure_networks") do
        require_relative "cap/configure_networks"
        Cap::ConfigureNetworks
      end

      guest_capability("cumulus", "change_host_name") do
        require_relative "cap/change_host_name"
        Cap::ChangeHostName
      end
    end
  end
end
