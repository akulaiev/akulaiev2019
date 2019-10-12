#
# Be sure to run `pod lib lint akulaiev2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'akulaiev2019'
  s.homepage         = 'https://github.com/akulaiev'
  s.source           = { :git => 'https://github.com/akulaiev/akulaiev2019', :tag => 'v0.1.0' }
  s.version          = '0.1.0'
  s.summary          = 'akulaiev2019 - for learning purposes'
  s.framework        = 'CoreData'
  s.description      = 'CocoaPod created for learning purposes. Uses CoreData Framework.'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'akulaiev' => 'akulaiev@student.unit.ua' }
  s.ios.deployment_target = '8.0'
  s.swift_version    = '5.0'
  s.source_files     = 'akulaiev2019/Classes/**/*.swift'
  s.resource_bundles = {
    'akulaiev2019' => ['akulaiev2019/Classes/**/*.xcdatamodeld']
  }
end
