# Class: holland
# ===========================
#
# This module will install and configure holland on a system. Holland is a database backup tool for MySQL and PostgreSQL databases. http://hollandbackup.org
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `backupsets`
# Type: Optional[Hash]
# Default: undef
# Hash of backupsets to create via holland::backupset
#
# * `config_options`
# Type: Optional[Hash]
# Default: undef
# Hash of options to set in /etc/holland/holland.conf using create_ini_settings. Each top level hash key is a section in the ini file.
#
# * `merge_backupsets`
# Type: Boolean
# Default: true
# Look up all instances of holland::backupsets and deep merge them together.
#
# * `merge_config_options`
# Type: Boolean
# Default: true
# Look up all instances of holland::config_options and deep merge them together.
#
# * `merge_modules`
# Type: Boolean
# Default: true
# Look up all instances of holland::modules and deep merge them together.
#
# * `modules`
# Type: Variant[Array,String,undef]
# Default: undef
# List of backup modules to install.
# e.g. [ 'mysqldump', 'xtrabackup' ]
#
# * `package_ensure`
# Type: Enum['absent','latest','present']
# Default: present
# What to pass to ensure for package resources.
#
# * `package_name`
# Type: String
# Default: 'holland'
# The package name to use when installing the main holland package.
#
# * `package_prefix`
# Type: String
# Default: 'holland-'
# String to prefix to module names when installing.
#
# * `package_repo`
# Type: String
# Default: "Yumrepo['epel']"
# The package_repo to require on package resources.
#
# Examples
# --------
#
# @example
#    class { 'holland':
#      modules => [ 'mysqldump', 'xtrabackup' ],
#    }
#
# Authors
# -------
#
# Damon Conway <vstraylight@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2018 Damon Conway, unless otherwise noted.
#
class holland (
  Optional[Array] $active_backupsets                = undef,
  Optional[Hash] $backupsets                        = undef,
  Stdlib::Absolutepath $config_d                    = $holland::params::config_d,
  String $config_file                               = $holland::params::config_file,
  Stdlib::Absolutepath $backupsets_dir              = "${config_d}/backupsets",
  Optional[Hash] $config_options                    = undef,
  Optional[Array] $install_options                  = undef,
  Boolean $merge_backupsets                         = true,
  Boolean $merge_config_options                     = true,
  Boolean $merge_modules                            = true,
  Optional[Hash] $modules                           = $holland::params::modules,
  Enum['absent','present','latest'] $package_ensure = $holland::params::package_ensure,
  String $package_name                              = $holland::params::package_name,
  String $package_prefix                            = $holland::params::package_prefix,
  Optional[Hash] $providers                         = undef,
  Stdlib::Absolutepath $providers_dir               = "${config_d}/providers",
) inherits holland::params {

  contain holland::install
  contain holland::setup
  contain holland::backupsets
  contain holland::providers

  Class['holland::install']
  ->Class['holland::setup']
  ->Class['holland::backupsets']
  ->Class['holland::providers']

}
