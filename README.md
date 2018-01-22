# Vagrant::Cumulus

This is a [Vagrant](http://www.vagrantup.com) 1.7+ plugin that adds a Cumulus Linux guest to Vagrant, allowing for OS detection and network configuration. Cumulus Linux is based off Debian, and so why need a plugin, you ask. Cumulus Linux names its front panel ports swp* instead of eth*, reserving eth0 for the management interface name. This foils interface configuration. Furthermore, Cumulus Linux ships with ifupdown2, a vastly improved, scalable and feature-rich improvement to the venerable ifupdown module in Debian for configuring interfaces. This plugin therefore exploits these differences of Cumulus Linux from Debian, leaving the rest to the Debian plugin.

> **NOTE:** This plugin requires Vagrant 1.7+,

## Features

* Detect Cumulus Linux
* Configure network interfaces, including management and front panel ports
* Use ifupdown2 instead of ifupdown for interface configuration


## Installation

Install using standard Vagrant 1.7+ plugin installation methods.  The fastest way to get started is to use the standard Vagrant Cloud images:

```
$ vagrant plugin install vagrant-cumulus

## Usage

... (create a Vagrant environment in a directory):
$ vagrant init CumulusVX
...
$ vagrant up
```
## Usage

## Contributing

1. Fork it ( https://github.com/[my-github-username]/vagrant-cumulus/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
