require 'set'
require 'tempfile'
require "vagrant/util/template_renderer"
require_relative "../version"

module VagrantPlugins
  module GuestCumulus
    module Cap
      # Configure Cumulus Linux mgmt and front panel ports
      class ConfigureNetworks
        include Vagrant::Util

        def self.vm_network_config(machine, interface)
          machine.config.vm.networks[interface-1]
        end

        def self.configure_networks(machine, networks)
          machine.communicate.tap do |comm|
            # First, remove any previous network modifications
            # from the interface file.
            comm.sudo("sed -e '/^#VAGRANT-BEGIN/,$ d' /etc/network/interfaces > /tmp/vagrant-network-interfaces.pre")
            comm.sudo("sed -ne '/^#VAGRANT-END/,$ p' /etc/network/interfaces | tail -n +2 > /tmp/vagrant-network-interfaces.post")

            # Accumulate the configurations to add to the interfaces file as
            # well as what interfaces we're actually configuring since we use that
            # later.
            interfaces = Set.new
            entries = []
            networks.each do |network|
              interfaces.add(network[:interface])

              type, config = vm_network_config(machine, network[:interface])
              if config[:cumulus__intname]
                network[:name] = config[:cumulus__intname]
              else
                network[:name] = network[:interface] == 0 ? 'eth0' : "swp#{network[:interface]}"
              end

              entry = TemplateRenderer.render("guests/cumulus/network_#{network[:type]}",
                                              options: network,
                                              template_root: "#{VagrantPlugins::GuestCumulus.source_root}/templates")

              entries << entry
            end

            # Perform the careful dance necessary to reconfigure
            # the network interfaces
            temp = Tempfile.new("vagrant")
            temp.binmode
            temp.write(entries.join("\n"))
            temp.close

            comm.upload(temp.path, "/tmp/vagrant-network-entry")

            comm.sudo('cat /tmp/vagrant-network-interfaces.pre /tmp/vagrant-network-entry /tmp/vagrant-network-interfaces.post > /etc/network/interfaces')
            comm.sudo('rm -f /tmp/vagrant-network-interfaces.pre /tmp/vagrant-network-entry /tmp/vagrant-network-interfaces.post')

            # ifreload will reload the interfaces correctly
            comm.sudo("/sbin/ifreload -a")
          end
        end
      end
    end
  end
end
