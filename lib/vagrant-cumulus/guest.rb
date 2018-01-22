module VagrantPlugins
  module GuestCumulus
    class Guest < Vagrant.plugin("2", :guest)
      
      def detect?(machine)
        machine.communicate.test("cat /etc/os-release | grep Cumulus")
      end
    end
  end
end
