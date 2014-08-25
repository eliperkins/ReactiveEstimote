#
# Be sure to run `pod lib lint ReactiveEstimote.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ReactiveEstimote"
  s.version          = "0.1.0"
  s.summary          = "ReactiveCocoa extensions for the Estimote SDK."
  s.description      = <<-DESC
                       A few handy extensions for working with the Estimote SDK,
                       together with ReactiveCocoa.

                       This library came to be after attempting to work with editing
                       properties of an `ESTBeacon` object, but needing to wait
                       for the connection to the device.
                       DESC
  s.homepage         = "https://github.com/eliperkins/ReactiveEstimote"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Eli Perkins" => "eli.j.perkins@gmail.com" }
  s.source           = { :git => "https://github.com/eliperkins/ReactiveEstimote.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_eliperkins'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.dependency 'ReactiveCocoa', '~> 2.3.1'
  s.dependency 'EstimoteSDK', '~> 2.0.1'
end
