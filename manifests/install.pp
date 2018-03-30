# holland::install
#
# Installs the holland packages.
#
# @summary Install holland packages and module packages.
#
# @example
#   include holland::install
#
class holland::install {

  $modules        = $holland::_modules
  $package_ensure = $holland::package_ensure
  $package_name   = $holland::package_name
  $package_prefix = $holland::package_prefix
  $package_repo   = $holland::package_repo

  Package {
    ensure  => $package_ensure,
    require => $package_repo,
  }

  package { 'holland': name => $package_name, }

  package { "${package_prefix}common": }

  if $modules {
    if $modules.is_a(String) {
      $mod_name = "${package_prefix}${modules}"
      package { $mod_name: }
    } elsif $modules.is_a(Array) {
      $modules.each |$mod| {
        $mod_name = "${package_prefix}${mod}"
        package { $mod_name: }
      }
    } elsif $modules.is_a(Hash) {
      $modules.each |$mod,$opts| {
        $mod_name = "${package_prefix}${mod}"
        package { $mod_name: * => $opts }
      }
    }
  }

}
