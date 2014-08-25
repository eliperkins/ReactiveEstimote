Pod::Spec.new do |s|
  s.name             = "ReactiveEstimote"
  s.version          = "0.1.1"
  s.summary          = "ReactiveCocoa extensions for the Estimote SDK."
  s.description      = <<-DESC
                       A few handy extensions for working with the Estimote SDK,
                       together with ReactiveCocoa.

                       This library came to be after attempting to work with editing
                       properties of an `ESTBeacon` object, but needing to wait
                       for the connection to the device.
                       DESC
  s.homepage         = "https://github.com/eliperkins/ReactiveEstimote"
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
